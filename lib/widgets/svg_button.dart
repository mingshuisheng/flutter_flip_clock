import 'package:flipclock/widgets/button.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends Button {
  SvgButton({
    super.key,
    required this.assetName,
    required super.onClick,
    required this.hoverMessage,
    this.color = const Color(0xff000000),
  });

  final String assetName;
  final Color color;
  final String hoverMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.height * 0.2;
    return SingleChildComposeBuilder(
      composeWidget: super.getComposeWidget()
        ..addAll([
          (child) => buttonSize >= 20
              ? Tooltip(
                  message: hoverMessage,
                  child: child,
                )
              : Container(
                  child: child
                ),
          (child) => SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: child,
              ),
        ]),
      child: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
