part of 'fc_weather_shader.dart';

class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;

  ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..translate(size.width, size.height)
      ..rotate(180 * degrees2Radians)
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..shader = shader,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
