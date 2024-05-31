import 'package:flipclock/types.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flutter/cupertino.dart';

final List<SingleChildBuilder> widgets = [
  (w) => DefaultTextStyle(
        style: const TextStyle(fontFamily: "Times New Roman"),
        child: w,
      )
];

class MyDefaultWidget extends BaseSingleChildCompose {
  const MyDefaultWidget({super.key, required super.child});

  @override
  List<SingleChildBuilder> getComposeWidget() {
    return widgets;
  }
}
