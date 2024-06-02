import 'package:flipclock/widgets/button.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends Button {
  SvgButton({
    super.key,
    required this.assetName,
    required super.onClick,
    this.color = const Color(0xff000000),
  });

  final String assetName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.height * 0.2;
    return SingleChildComposeBuilder(
      composeWidget: super.getComposeWidget()
        ..addAll([
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
