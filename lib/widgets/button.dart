import 'package:flipclock/types.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flutter/cupertino.dart';

import '../app_state.dart';

final List<SingleChildBuilder> widgets = [
];

class Button extends BaseSingleChildCompose {
  Button({super.key, super.child, required this.onClick});

  final Click onClick;

  final appStateController = getAppStateController();

  @override
  List<SingleChildBuilder> getComposeWidget() {
    return [
          (child) =>
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (e) {
              appStateController.disableWindowFrame.value = true;
            },
            onExit: (e) {
              appStateController.disableWindowFrame.value = false;
            },
            child: child,
          ),
          (child) =>
          GestureDetector(
            onTap: onClick,
            child: child,
          ),
    ];
  }
}
