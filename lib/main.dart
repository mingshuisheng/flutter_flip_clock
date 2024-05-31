import 'package:flipclock/app.dart';
import 'package:flipclock/constants.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  const width = 710.0;
  const minWidth = 200.0;
  WindowOptions windowOptions = const WindowOptions(
    size: Size(width, width / aspectRatio),
    backgroundColor: Colors.transparent,
    // center: true,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    alwaysOnTop: true,
    fullScreen: false,
    minimumSize: Size(minWidth, minWidth / aspectRatio),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);
    await windowManager.setAspectRatio(aspectRatio);
  });
  runApp(const App());
}
