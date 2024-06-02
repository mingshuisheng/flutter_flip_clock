import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flipclock/sizes.dart';
import 'package:flipclock/types.dart';

class AppConfig {
  AppConfig(
      {required this.dotColor,
      required this.cardColor,
      required this.fontColor,
      required this.x,
      required this.y,
      required this.locked,
      required this.windowLevel,
      required this.width,
      required this.height});

  static const jsonEncoder = JsonEncoder.withIndent('  ');
  static final defaultAppConfig = AppConfig(
      dotColor: const Color(0xffcccccc),
      cardColor: const Color(0xff191919),
      fontColor: const Color(0xffcccccc),
      x: 100,
      y: 100,
      locked: false,
      windowLevel: WindowLevel.top,
      width: defaultWindowSize.width,
      height: defaultWindowSize.height);
  static const configFilePath = "./FlipClock.json";

  Color dotColor;
  Color cardColor;
  Color fontColor;
  double width;
  double height;
  double x;
  double y;
  bool locked;
  WindowLevel windowLevel;

  static Future<AppConfig> loadFromFile() async {
    final file = File(configFilePath);
    var configFileExists = await file.exists();
    if (!configFileExists) {
      file.writeAsString(jsonEncoder.convert(defaultAppConfig.toJson()));
      return defaultAppConfig;
    }
    final s = await file.readAsString();
    final json = jsonDecode(s);
    return AppConfig.fromJson(json);
  }

  saveToFile() async {
    final file = File(configFilePath);
    file.writeAsString(jsonEncoder.convert(toJson()));
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    final dotColor = json.containsKey("dotColor")
        ? parseColor(json["dotColor"])
        : defaultAppConfig.dotColor;
    final cardColor = json.containsKey("cardColor")
        ? parseColor(json["cardColor"])
        : defaultAppConfig.cardColor;
    final fontColor = json.containsKey("fontColor")
        ? parseColor(json["fontColor"])
        : defaultAppConfig.fontColor;
    final width = json["width"] ?? defaultAppConfig.width;
    final height = json["height"] ?? defaultAppConfig.height;
    final x = json["x"] ?? defaultAppConfig.x;
    final y = json["y"] ?? defaultAppConfig.y;
    final locked = json["locked"] ?? defaultAppConfig.locked;
    final windowLevel = json.containsKey("windowLevel")
        ? parseWindowLevel(json["windowLevel"])
        : defaultAppConfig.windowLevel;

    final appConfig = AppConfig(
        dotColor: dotColor,
        cardColor: cardColor,
        fontColor: fontColor,
        width: width,
        height: height,
        x: x,
        y: y,
        locked: locked,
        windowLevel: windowLevel);

    return appConfig;
  }

  Map<String, dynamic> toJson() {
    return {
      "dotColor": colorToString(dotColor),
      "cardColor": colorToString(cardColor),
      "fontColor": colorToString(fontColor),
      "width": width,
      "height": height,
      "x": x,
      "y": y,
      "locked": locked,
      "windowLevel": windowLevelToString(windowLevel)
    };
  }
}

Color parseColor(String s) {
  return Color(int.parse("0xff${(s).replaceAll("#", "")}"));
}

String colorToString(Color c) {
  return "#${c.value.toRadixString(16)}";
}

WindowLevel parseWindowLevel(String s) {
  switch (s) {
    case "top":
      return WindowLevel.top;
    case "bottom":
      return WindowLevel.bottom;
    default:
      return WindowLevel.normal;
  }
}

String windowLevelToString(WindowLevel windowLevel) {
  switch (windowLevel) {
    case WindowLevel.top:
      return "top";
    case WindowLevel.bottom:
      return "bottom";
    case WindowLevel.normal:
      return "normal";
  }
}
