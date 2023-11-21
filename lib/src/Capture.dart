import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Future<Uint8List?> captureImage(GlobalKey key, double ratio) async {
  return Future.delayed(const Duration(milliseconds: 100), () async {
    try {
      BuildContext? context = key.currentContext;
      RenderRepaintBoundary? boundary =
      context?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return null;
      }
      print(boundary.size);

      ui.Image? image = await boundary.toImage(pixelRatio:  ratio);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      Uint8List? bytes = byteData?.buffer.asUint8List();
      return bytes;
    } on Exception {
      throw (Exception);
    }
  });
}
