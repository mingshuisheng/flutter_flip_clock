import 'dart:async';

import 'package:flipclock/app_config.dart';
import 'package:flipclock/types.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController {
  AppStateController(this.appConfig) {
    _locked = appConfig.locked.obs;
    _windowLevel = appConfig.windowLevel.obs;
    ever(_locked, (_) {
      appConfig.locked = _locked.value;
      saveConfig();
    });
    ever(_windowLevel, (_) {
      appConfig.windowLevel = _windowLevel.value;
      saveConfig();
    });
  }

  final AppConfig appConfig;
  Timer? saveConfTimer;

  saveConfig() {
    saveConfTimer?.cancel();
    saveConfTimer = Timer(const Duration(milliseconds: 1500), () async {
      await appConfig.saveToFile();
    });
  }

  final _disableWindowFrame = false.obs;

  get disableWindowFrame => _disableWindowFrame.value;

  set disableWindowFrame(value) => _disableWindowFrame.value = value;

  late final RxBool _locked;

  get locked => _locked.value;

  void lock() => _locked.value = true;

  void unlock() => _locked.value = false;

  void toggleLock() => _locked.value = !locked;

  late final Rx<WindowLevel> _windowLevel;

  get windowLevel => _windowLevel.value;

  WindowLevel toggleWindowLevel() {
    _windowLevel.value = WindowLevel
        .values[(_windowLevel.value.index + 1) % WindowLevel.values.length];
    return _windowLevel.value;
  }
}

AppStateController getAppStateController() {
  return Get.find();
}

const positionSvgMap = {
  WindowLevel.top: "assets/to_top.svg",
  WindowLevel.normal: "assets/to_normal.svg",
  WindowLevel.bottom: "assets/to_bottom.svg",
};
