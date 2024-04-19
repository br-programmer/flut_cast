/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsGifsGen {
  const $AssetsGifsGen();

  /// File path: assets/gifs/clear_sky.gif
  AssetGenImage get clearSky =>
      const AssetGenImage('assets/gifs/clear_sky.gif');

  /// File path: assets/gifs/clouds.gif
  AssetGenImage get clouds => const AssetGenImage('assets/gifs/clouds.gif');

  /// File path: assets/gifs/drizzle.gif
  AssetGenImage get drizzle => const AssetGenImage('assets/gifs/drizzle.gif');

  /// File path: assets/gifs/rain.gif
  AssetGenImage get rain => const AssetGenImage('assets/gifs/rain.gif');

  /// File path: assets/gifs/snow.gif
  AssetGenImage get snow => const AssetGenImage('assets/gifs/snow.gif');

  /// File path: assets/gifs/thunderstorm.gif
  AssetGenImage get thunderstorm =>
      const AssetGenImage('assets/gifs/thunderstorm.gif');

  /// List of all assets
  List<AssetGenImage> get values =>
      [clearSky, clouds, drizzle, rain, snow, thunderstorm];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/compass.png
  AssetGenImage get compass => const AssetGenImage('assets/images/compass.png');

  /// List of all assets
  List<AssetGenImage> get values => [compass];
}

class Assets {
  Assets._();

  static const String package = 'fc_ui';

  static const $AssetsGifsGen gifs = $AssetsGifsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  static const String package = 'fc_ui';

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/fc_ui/$_assetName';
}
