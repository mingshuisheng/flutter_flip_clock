import 'package:flipclock/widgets/button.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends Button {
  SvgButton({
    super.key,
    required this.assetName,
    required super.onClick,
    this.width = 50,
    this.height = 50,
    this.color = const Color(0xff000000),
  });

  final String assetName;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SingleChildComposeBuilder(
      composeWidget: super.getComposeWidget()
        ..addAll([
          (child) => SizedBox(
                width: height,
                height: height,
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
