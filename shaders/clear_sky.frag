#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec3 iResolution;

out vec4 fragColor;


float iSphere( in vec3 ro, in vec3 rd, in vec4 sp, out vec3 nor )
{
    float t = -1.0;
	nor = vec3(0.0);
	
	vec3  rc = ro - sp.xyz;
	float b =  dot(rc,rd);
	float c =  dot(rc,rc) - sp.w*sp.w;
	float k = b*b - c;
	if( k>0.0 )
	{
		t = -b - sqrt(k);
		nor = normalize( (ro+rd*t) - sp.xyz );
	}

	return t;
}



void main()
{
    vec2 fragCoord = FlutterFragCoord();
	vec2 q = fragCoord.xy / iResolution.xy;
	vec2 p = -1.0 + 2.0*q;
	p.x *= iResolution.x/iResolution.y;
	
	vec3 sunDir_o = normalize(vec3(-0.0, -0.6, 1.0));
	vec3 sunDir = sunDir_o;
	float sunrot = -iTime / 40.0;
	sunDir.y = sunDir_o.y * cos(sunrot) - sunDir_o.z * sin(sunrot);
	sunDir.z = sunDir_o.y * sin(sunrot) + sunDir_o.z * cos(sunrot);

	// camera
	vec3  ro = vec3(0.0,0.0,0.0);
    vec3  rd_o = normalize( vec3(p.xy,-2.0) );
	vec3  rd_y = rd_o;
	float camrot = 0.0;// - iMouse.y / 100.0;
	rd_y.y = rd_o.y * cos(camrot) - rd_o.z * sin(camrot);
	rd_y.z = rd_o.y * sin(camrot) + rd_o.z * cos(camrot);
	camrot = 0.0;// - iMouse.x / 100.0;
	vec3 rd = rd_y;
	rd.x = rd_y.x * cos(camrot) - rd_y.z * sin(camrot);
	rd.z = rd_y.x * sin(camrot) + rd_y.z * cos(camrot);

	vec3 seamultiplier = vec3(1.0);
	
	vec3 earthnor = vec3(0.0);
	float t2 = iSphere(ro, rd, vec4(0.0, -900.0, 0.0, 899.99), earthnor);
	if (t2 > 0.0)
	{
		ro = rd * t2;
		earthnor = normalize(earthnor + sin(ro.xyz*1300.0 + iTime) * 0.01 + cos(ro.zxy*2000.0 + iTime) * 0.01);
		rd = rd - 2.0 * earthnor * dot(rd, earthnor);
		seamultiplier = vec3(0.5);
	}
	
	vec3 nor;
	float t = -iSphere(ro, rd, vec4(0.0, 900.0, 0.0, 1000.0), nor);
	vec3 skycolor = vec3(0.0, 0.6, 1.0);
	vec3 skyabsorbsion = (t * 0.003) * skycolor;
	vec3 col = skyabsorbsion * clamp(dot(vec3(0.0, -1.0, 0.0), sunDir), 0.0, 1.0);
	
	vec3 suncol = vec3(0.0);
	
	// compute sun
	if (dot(rd, sunDir) < -0.999)
	{
		suncol = vec3(2.0, 2.0, 2.0) - skyabsorbsion * 2.3;
	}
	
	col += 2.0 * pow(clamp(-dot(rd, sunDir) - 0.0, 0.0, 1.0), 16.0) * (vec3(2.0, 2.0, 2.0) - skyabsorbsion * 2.3) * (t * 0.0015);
	
	col += suncol;
	
	col *= seamultiplier;
	
	col = pow( clamp(col,0.0,1.0), vec3(0.45) );
	
	//vec2 uv = fragCoord.xy / iResolution.xy;
	fragColor = vec4(col, 1.0);
}