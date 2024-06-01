import 'package:flipclock/widgets/base_widget.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flipclock/widgets/time_area.dart';
import 'package:flipclock/widgets/tools_cover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final showTools = false.obs;
    var mouseDown = false;
    return SingleChildComposeBuilder(
      composeWidget: [
        (child) => BaseWidget(child: child),
        (child) => MouseRegion(
              onExit: (e) {
                if (!mouseDown) {
                  showTools.value = false;
                }
              },
              onEnter: (e) {
                mouseDown = false;
                showTools.value = true;
              },
              child: Listener(
                onPointerDown: (e) {
                  mouseDown = true;
                  showTools.value = true;
                },
                onPointerUp: (e) {
                  mouseDown = false;
                },
                child: child,
              ),
            ),
      ],
      child: Stack(
        children: [
          const TimeArea(),
          Obx(() => showTools.value ? const ToolsCover() : Container()),
        ],
      ),
    );
  }
}
