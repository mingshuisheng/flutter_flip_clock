import 'package:get/get.dart';

class AppStateController extends GetxController {
  final _disableWindowFrame = false.obs;
  get disableWindowFrame => _disableWindowFrame.value;
  set disableWindowFrame(value) => _disableWindowFrame.value = value;

  final _locked = false.obs;
  get locked => _locked.value;
  void lock() => _locked.value = true;
  void unlock() => _locked.value = false;
  void toggleLock() => _locked.value = !locked;

  final _windowLevel = WindowLevel.top.obs;
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

enum WindowLevel {
  top,
  normal,
  bottom,
}

const positionSvgMap = {
  WindowLevel.top: "assets/to_top.svg",
  WindowLevel.normal:"assets/to_normal.svg",
  WindowLevel.bottom: "assets/to_bottom.svg",
};