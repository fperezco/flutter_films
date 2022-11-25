/**
 * From https://stackoverflow.com/questions/73387663/flutter-pageview-not-swipeable-on-web-using-chrome-web-browser
 * Because Flutter compiles for every platform but not now... ¬¬
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MouseDraggableScrollBehavior extends MaterialScrollBehavior {
@override
Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}