import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flipclock/widgets/svg_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../app_state.dart';
import '../sizes.dart';
import '../types.dart';

class ToolsCover extends BaseStatelessWidget {
  const ToolsCover({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        color: const Color(0x66aaaaaa),
        border: Border.all(color: const Color(0xffcccccc), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: calcToolPadding(size),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(() {
                  final assetName = appStateController.locked
                      ? "assets/lock.svg"
                      : "assets/unlock.svg";
                  return SvgButton(
                    hoverMessage: appStateController.locked ? "点击解锁" : "点击锁定",
                    assetName: assetName,
                    onClick: handleLockClick,
                  );
                }),
                const Gap(),
                Obx(() {
                  return SvgButton(
                    assetName: positionSvgMap[appStateController.windowLevel]!,
                    hoverMessage: "窗口置顶或置底",
                    onClick: handleWindowLevelClick,
                  );
                }),
              ],
            ),
            SvgButton(
              assetName: "assets/close.svg",
              hoverMessage: "关闭窗口",
              onClick: () async => await windowManager.close(),
            )
          ],
        ),
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gapSize = size.height * 0.04;
    return SizedBox(
      width: gapSize,
    );
  }
}
