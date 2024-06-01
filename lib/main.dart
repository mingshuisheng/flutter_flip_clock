import 'dart:convert';
import 'dart:io';

import 'package:flipclock/app.dart';
import 'package:flipclock/constants.dart';
import 'package:flipclock/app_state.dart';
import 'package:flipclock/window_listener.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const path = "./conf.json";
  final file = File(path);
  var s = await file.readAsString();
  var json = jsonDecode(s);
  print("a: ${json["a"]}");


  // init global app state
  var appStateController = Get.put(AppStateController());

  await windowManager.ensureInitialized();
  const width = 710.0;
  const minWidth = 200.0;
  WindowOptions windowOptions = const WindowOptions(
    size: Size(width, width / aspectRatio),
    backgroundColor: Colors.transparent,
    // center: true,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    fullScreen: false,
    minimumSize: Size(minWidth, minWidth / aspectRatio),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);
    await windowManager.setAspectRatio(aspectRatio);
    if (appStateController.windowLevel.value == WindowLevel.top) {
      await windowManager.setAlwaysOnTop(true);
    } else if (appStateController.windowLevel.value == WindowLevel.bottom) {
      await windowManager.setAlwaysOnBottom(true);
    }
    windowManager.addListener(MyWindowListener());
  });

  runApp(const App());
}
