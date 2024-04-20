import 'dart:async';
import 'dart:ui' as ui;

import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

part 'shader_painter.dart';

typedef ShaderData = ({ImageProvider? image, String shaderName});

class FCWeatherShader extends StatefulWidget {
  const FCWeatherShader({super.key, required this.shaderData});
  final ShaderData shaderData;

  @override
  State<FCWeatherShader> createState() => FC_WeatherShaderState();
}

class FC_WeatherShaderState extends State<FCWeatherShader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..repeat();

  late var data = widget.shaderData;
  late var hasBackgroundImage = data.image != null;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasBackgroundImage) {
        loadImage();
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FCWeatherShader oldWidget) {
    data = widget.shaderData;
    hasBackgroundImage = data.image != null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int startTime = 0;

  double get _elapsedTimeInSeconds =>
      (DateTime.now().millisecondsSinceEpoch - startTime) / 1000;

  ui.Image? image;

  Future<void> loadImage() async {
    image = await loadImageFromAsset(data.image!);
    setState(() {});
  }

  Future<ui.Image> loadImageFromAsset(ImageProvider image) async {
    late ImageStreamListener listener;

    final completer = Completer<ui.Image>();
    final imageStream = image.resolve(ImageConfiguration.empty);

    listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        imageStream.removeListener(listener);
        completer.complete(imageInfo.image);
      },
      onError: (exception, stackTrace) {
        imageStream.removeListener(listener);
        completer.completeError(exception);
      },
    );

    imageStream.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    startTime = DateTime.now().millisecondsSinceEpoch;

    return LayoutBuilder(builder: (context, snapshot) {
      final size = Size(context.mediaQuery.size.width, snapshot.maxHeight);
      return SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: loadShader(data.shaderName),
          builder: (context, snapshot) {
            if (snapshot.hasData && (hasBackgroundImage == (image != null))) {
              final shader = snapshot.data!;
              shader
                ..setFloat(1, size.width)
                ..setFloat(2, size.height);

              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  shader.setFloat(0, _elapsedTimeInSeconds);
                  if (hasBackgroundImage) {
                    shader.setImageSampler(0, image!);
                  }
                  return CustomPaint(
                    painter: ShaderPainter(shader),
                  );
                },
              );
            } else {
              return SizedBox.expand();
            }
          },
        ),
      );
    });
  }
}

Future<ui.FragmentShader> loadShader(String shaderName) async {
  final program = await ui.FragmentProgram.fromAsset(
    'shaders/$shaderName.frag',
  );
  return program.fragmentShader();
}
