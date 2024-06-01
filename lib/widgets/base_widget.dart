import 'package:flipclock/types.dart';
import 'package:flipclock/widgets/single_child_utils.dart';
import 'package:flipclock/widgets/window_frame.dart';
import 'package:flutter/cupertino.dart';

import 'my_default_widget.dart';

final List<SingleChildBuilder> widgets = [
  (w) => WindowFrame(child: w),
  (w) => MyDefaultWidget(child: w),
  (w) => Directionality(textDirection: TextDirection.ltr, child: w)
];

class BaseWidget extends BaseSingleChildCompose {
  const BaseWidget({super.key, required super.child});

  @override
  List<SingleChildBuilder> getComposeWidget() {
    return widgets;
  }
}
