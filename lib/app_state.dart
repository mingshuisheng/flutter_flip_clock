import 'package:get/get.dart';

class AppStateController extends GetxController {
  var disableWindowFrame = false.obs;
  var locked = false.obs;
  var windowLevel = WindowLevel.top.obs;

  void lock() => locked.value = true;

  void unlock() => locked.value = false;

  void toggleLock() => locked.value = !locked.value;

  WindowLevel toggleWindowLevel() {
    windowLevel.value =
        WindowLevel.values[(windowLevel.value.index + 1) % WindowLevel.values.length];
    return windowLevel.value;
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