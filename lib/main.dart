import 'package:flipclock/app.dart';
import 'package:flipclock/app_config.dart';
import 'package:flipclock/sizes.dart';
import 'package:flipclock/app_state.dart';
import 'package:flipclock/types.dart';
import 'package:flipclock/window_listener.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appConfig = await AppConfig.loadFromFile();
  final windowSize = Size(appConfig.width, appConfig.height);
  final position = Offset(appConfig.x, appConfig.y);

  // init global app state
  var appStateController = Get.put(AppStateController(appConfig));

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    size: windowSize,
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    fullScreen: false,
    minimumSize: minWindowSize,
    skipTaskbar: true
  );

  // position比较特殊，如果在waitUntilReadyToShow的回到函数里面，那么窗口的位置会出现跳变
  await windowManager.setPosition(position);

  // 对窗口的设置尽量放在waitUntilReadyToShow的回到函数里面
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);
    await windowManager.setAspectRatio(windowSize.aspectRatio);
    if (appStateController.windowLevel == WindowLevel.top) {
      await windowManager.setAlwaysOnTop(true);
    } else if (appStateController.windowLevel == WindowLevel.bottom) {
      await windowManager.setAlwaysOnBottom(true);
    }
    windowManager
        .addListener(MyWindowListener(appStateController: appStateController));
  });

  runApp(const App());
}
