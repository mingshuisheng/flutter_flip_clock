import 'dart:math';

import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import '../colors.dart';

const cardColor = Colors.black;

const space = 1.0;
const radiusRatio = 0.12;
const perspective = 0.001;

class Number extends BaseStatelessWidget {
  const Number({super.key, this.num = 0, this.max = 9});

  final int num;
  final int max;

  @override
  Widget build(BuildContext context) {
    final next = num;
    final current = num - 1 < 0 ? max : num - 1;

    final size = MediaQuery.of(context).size;
    final width = size.width * 100 / 710;
    final height = size.height;
    final cardSize = height / 2;
    final textStructStyle = StrutStyle(
        fontSize: height, leading: 0, height: 1.035, forceStrutHeight: true);
    final textStyle = TextStyle(fontSize: height, color: Colors.white);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          UpFixedCard(
              number: next,
              size: cardSize,
              textStructStyle: textStructStyle,
              style: textStyle),
          Positioned(
            top: height / 2 + space,
            child: DownFixedCard(
              number: current,
              size: cardSize,
              textStructStyle: textStructStyle,
              style: textStyle,
            ),
          ),
          TweenAnimationBuilder(
              key: ValueKey(next),
              tween: Tween<double>(begin: 10.0, end: 180.0),
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 600),
              builder: (_, angle, __) {
                return angle <= 90
                    ? UpRotateCard(
                        number: current,
                        angle: angle,
                        size: cardSize,
                        textStructStyle: textStructStyle,
                        style: textStyle,
                      )
                    : Positioned(
                        top: height / 2 + space,
                        child: DownRotateCard(
                          number: next,
                          angle: angle - 180,
                          size: cardSize,
                          textStructStyle: textStructStyle,
                          style: textStyle,
                        ),
                      );
              }),
        ],
      ),
    );
  }
}

abstract class BaseCard extends BaseStatelessWidget {
  const BaseCard(
      {super.key,
      required this.number,
      required this.size,
      required this.textStructStyle,
      required this.style});

  final int number;
  final double size;
  final StrutStyle textStructStyle;
  final TextStyle style;
}

class UpFixedCard extends BaseCard {
  const UpFixedCard(
      {super.key,
      required super.number,
      required super.size,
      required super.textStructStyle,
      required super.style});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * radiusRatio),
      child: Container(
        color: cardColor,
        width: size,
        height: size - space,
        child: Text(
          "${super.number}",
          strutStyle: textStructStyle,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DownFixedCard extends BaseCard {
  const DownFixedCard(
      {super.key,
      required super.number,
      required super.size,
      required super.textStructStyle,
      required super.style});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * radiusRatio),
      child: Container(
        color: cardColor,
        width: size,
        height: size - space,
        child: Transform(
          transform: Matrix4.identity()..translate(0.0, -size),
          child: Text(
            "$number",
            overflow: TextOverflow.visible,
            strutStyle: textStructStyle,
            style: style,
          ),
        ),
      ),
    );
  }
}

abstract class BaseRotateCard extends BaseCard {
  const BaseRotateCard(
      {super.key,
      required super.number,
      required super.size,
      required super.textStructStyle,
      required this.angle,
      required super.style});

  final double angle;
}

class UpRotateCard extends BaseRotateCard {
  const UpRotateCard(
      {super.key,
      required super.number,
      required super.size,
      required super.textStructStyle,
      required super.style,
      required super.angle});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, perspective)
        ..rotateX(angle * pi / 180),
      origin: Offset(size / 2, size),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * radiusRatio),
        child: Container(
          color: cardColor,
          width: size,
          height: size - space,
          child: Text(
            "$number",
            strutStyle: textStructStyle,
            style: style,
          ),
        ),
      ),
    );
  }
}

class DownRotateCard extends BaseRotateCard {
  const DownRotateCard(
      {super.key,
      required super.number,
      required super.size,
      required super.textStructStyle,
      required super.style,
      required super.angle});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, perspective)
        ..rotateX(angle * pi / 180),
      origin: Offset(size / 2, -space),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * radiusRatio),
        child: Container(
          color: cardColor,
          width: size,
          height: size - space,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, -size),
            child: Text(
              "$number",
              overflow: TextOverflow.visible,
              strutStyle: textStructStyle,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
