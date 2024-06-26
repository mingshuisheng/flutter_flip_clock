import 'package:flutter/widgets.dart';

typedef SingleChildBuilder = Widget Function(Widget);

typedef Click = Function();

enum WindowLevel {
  top,
  normal,
  bottom,
}
