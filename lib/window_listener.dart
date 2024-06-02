import 'package:flipclock/app_state.dart';
import 'package:window_manager/window_manager.dart';

class MyWindowListener with WindowListener {
  MyWindowListener({required this.appStateController});

  final AppStateController appStateController;

  @override
  void onWindowMoved() async {
    var position = await windowManager.getPosition();
    print("position: $position");

  }

  @override
  void onWindowResize() async {
    // 为什么在resize过程中取消AlwaysOnBottom？
    // 因为resize过程中会不断的闪烁
    // 未来如果windowManager解决了这个问题，那请帮忙移除它
    if (await windowManager.isAlwaysOnBottom()) {
      windowManager.setAlwaysOnBottom(false);
    }
  }

  @override
  void onWindowResized() async {
    var size = await windowManager.getSize();
    print("size: $size");
    // 为什么在resize过程中取消AlwaysOnBottom？
    // 因为resize过程中会不断的闪烁
    // 未来如果windowManager解决了这个问题，那请帮忙移除它
    if (appStateController.windowLevel == WindowLevel.bottom) {
      await windowManager.setAlwaysOnBottom(true);
    }
  }
}
