import 'package:flipclock/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'base_stateless_widget.dart';

class WindowFrame extends BaseStatelessWidget {
  const WindowFrame({super.key, super.child, this.borderSize = 10.0});

  final double borderSize;

  @override
  Widget build(BuildContext context) {
    final windowFrameController = Get.put(WindowFrameController());
    var appStateController = getAppStateController();
    return Listener(
      onPointerDown: (e) async {
        if (appStateController.disableWindowFrame ||
            appStateController.locked) {
          return;
        }
        if (windowFrameController.resizeDirection.value ==
            ResizeDirection.none) {
          // 为什么要取消AlwaysOnBottom？
          // 因为现在windowManager的AlwaysOnBottom在移动过程中会出现不断的闪烁
          // 如果未来这个问题解决了，那就请去掉它
          final alwaysOnBottom = await windowManager.isAlwaysOnBottom();
          if (alwaysOnBottom) {
            await windowManager.setAlwaysOnBottom(false);
          }
          await windowManager.startDragging();
          if (alwaysOnBottom) {
            await windowManager.setAlwaysOnBottom(alwaysOnBottom);
          }
        } else {
          final resizable = await windowManager.isResizable();
          await windowManager.setResizable(true);
          await windowManager.startResizing(
              directionToEdge[windowFrameController.resizeDirection.value]!);
          await windowManager.setResizable(resizable);
        }
      },
      onPointerHover: (e) async {
        if (appStateController.disableWindowFrame ||
            appStateController.locked) {
          return;
        }
        final localPosition = e.localPosition;
        final windowSize = MediaQuery.of(context).size;
        windowFrameController.resizeDirection.value =
            cursorResizeDirection(windowSize, localPosition, borderSize);
      },
      child: Obx(() => MouseRegion(
            cursor:
                resizeCursorMap[windowFrameController.resizeDirection.value]!,
            child: child,
          )),
    );
  }
}

class WindowFrameController extends GetxController {
  var resizeDirection = ResizeDirection.none.obs;
}

const Map<ResizeDirection, MouseCursor> resizeCursorMap = {
  ResizeDirection.none: SystemMouseCursors.basic,
  ResizeDirection.top: SystemMouseCursors.resizeUp,
  ResizeDirection.left: SystemMouseCursors.resizeLeft,
  ResizeDirection.right: SystemMouseCursors.resizeRight,
  ResizeDirection.bottom: SystemMouseCursors.resizeDown,
  ResizeDirection.topLeft: SystemMouseCursors.resizeUpLeft,
  ResizeDirection.bottomLeft: SystemMouseCursors.resizeDownLeft,
  ResizeDirection.topRight: SystemMouseCursors.resizeUpRight,
  ResizeDirection.bottomRight: SystemMouseCursors.resizeDownRight,
};

enum ResizeDirection {
  none,
  top,
  left,
  right,
  bottom,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight;
}

const Map<ResizeDirection, ResizeEdge> directionToEdge = {
  ResizeDirection.top: ResizeEdge.top,
  ResizeDirection.left: ResizeEdge.left,
  ResizeDirection.right: ResizeEdge.right,
  ResizeDirection.bottom: ResizeEdge.bottom,
  ResizeDirection.topLeft: ResizeEdge.topLeft,
  ResizeDirection.bottomLeft: ResizeEdge.bottomLeft,
  ResizeDirection.topRight: ResizeEdge.topRight,
  ResizeDirection.bottomRight: ResizeEdge.bottomRight,
};

const Map<int, ResizeDirection> resizeDirectionMap = {
  00: ResizeDirection.none,
  01: ResizeDirection.top,
  02: ResizeDirection.bottom,
  10: ResizeDirection.left,
  20: ResizeDirection.right,
  // 从结果来看，完全不能斜角，因为设置了aspectRatio之后，只有垂直方向有效
  // 11: ResizeDirection.topLeft,
  // 12: ResizeDirection.bottomLeft,
  // 21: ResizeDirection.topRight,
  // 22: ResizeDirection.bottomRight,
  11: ResizeDirection.top,
  12: ResizeDirection.bottom,
  21: ResizeDirection.top,
  22: ResizeDirection.bottom,
};

ResizeDirection cursorResizeDirection(
    Size windowSize, Offset position, double borderSize) {
  var xDirection = XDirection.none;
  if (position.dx < borderSize) {
    xDirection = XDirection.left;
  } else if (position.dx > windowSize.width - borderSize) {
    xDirection = XDirection.right;
  }

  var yDirection = YDirection.none;
  if (position.dy < borderSize) {
    yDirection = YDirection.top;
  } else if (position.dy > windowSize.height - borderSize) {
    yDirection = YDirection.bottom;
  }

  final directionNum = xDirection.num * 10 + yDirection.num;

  return resizeDirectionMap[directionNum]!;
}

enum XDirection {
  none(0),
  left(1),
  right(2);

  final int num;

  const XDirection(this.num);
}

enum YDirection {
  none(0),
  top(1),
  bottom(2);

  final int num;

  const YDirection(this.num);
}
