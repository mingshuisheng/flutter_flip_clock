import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flipclock/widgets/svg_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../app_state.dart';
import '../colors.dart';

class ToolsCover extends BaseStatelessWidget {
  const ToolsCover({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.height * 0.2;
    final appStateController = getAppStateController();
    final handleLockClick = appStateController.toggleLock;
    handleWindowLevelClick() async {
      final nextWindowLevel = appStateController.toggleWindowLevel();
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setAlwaysOnBottom(false);
      switch (nextWindowLevel) {
        case WindowLevel.top:
          await windowManager.setAlwaysOnTop(true);
        case WindowLevel.bottom:
          await windowManager.setAlwaysOnBottom(true);
        case WindowLevel.normal:
          {}
      }
    }

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: const Color(0xccaaaaaa),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(() {
                  final assetName = appStateController.locked.value
                      ? "assets/lock.svg"
                      : "assets/unlock.svg";
                  return SvgButton(
                    assetName: assetName,
                    width: buttonSize,
                    height: buttonSize,
                    onClick: handleLockClick,
                  );
                }),
                Obx(() {
                  var assetName =
                      positionSvgMap[appStateController.windowLevel.value]!;
                  return SvgButton(
                    assetName: assetName,
                    width: buttonSize,
                    height: buttonSize,
                    onClick: handleWindowLevelClick,
                  );
                }),
              ],
            ),
            SvgButton(
              assetName: "assets/close.svg",
              width: buttonSize,
              height: buttonSize,
              onClick: () async => await windowManager.close(),
            )
          ],
        ),
      ),
    );
  }
}
