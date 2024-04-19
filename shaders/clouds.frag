#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec3 iResolution;

out vec4 fragColor;

float hash(vec2 p) {
    p  = 50.0*fract( p*0.3183099 + vec2(0.71,0.113));
    return -1.0+2.0*fract( p.x*p.y*(p.x+p.y) );
}
float noise( in vec2 p ){
    vec2 i = floor( p );
    vec2 f = fract( p );
	
	vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( hash( i + vec2(0.0,0.0) ), 
                     hash( i + vec2(1.0,0.0) ), u.x),
                mix( hash( i + vec2(0.0,1.0) ), 
                     hash( i + vec2(1.0,1.0) ), u.x), u.y);
}
float fracNoise(vec2 uv){
    uv *= 8.0;
    mat2 m = mat2( 1.6,  1.2, -1.2,  1.6 );
	float fr  = 0.5000*noise( uv ); 
    uv = m*uv;
	fr += 0.2500*noise( uv ); uv = m*uv;
	fr += 0.1250*noise( uv ); uv = m*uv;
	fr += 0.0625*noise( uv ); uv = m*uv;
    fr = 0.5 + 0.5*fr;
    return fr;
}

float layers=3.;
void main()
{
    vec2 fragCoord = FlutterFragCoord();
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;
    
    vec2 speed= 2.*vec2(2.,cos(iTime*.03))*(.9+cos(.21+iTime*.023)*.2);
    uv+=speed;

    vec3 clouds,col;
    float passes;    
    vec2 uvOffset=.05*vec2(fracNoise(uv+iTime*.017));
    
    for(float i=0.f; i<layers; ++i){
        clouds = vec3(min(.9,smoothstep(.4-(i*.03),.75+(i*.035),fracNoise(i+uv+uvOffset))*fracNoise(uv+speed*.03*i)));
        col+=clouds;
        ++passes;
    }    
    col/=passes;
    col+=vec3(.25,.2,.5);
    col=min(col,vec3(.98));    

    fragColor = vec4(col,1.);
}

