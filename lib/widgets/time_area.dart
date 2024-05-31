import 'dart:async';

import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flipclock/widgets/number_group.dart';
import 'package:flipclock/widgets/splitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TimeArea extends BaseStatelessWidget {
  const TimeArea({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now().obs;

    Timer.periodic(const Duration(seconds: 1), (e) {
      dateTime.value = DateTime.now();
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => NumberGroup(num: dateTime.value.hour, max: 23)),
        const Splitter(),
        Obx(() => NumberGroup(num: dateTime.value.minute)),
        const Splitter(),
        Obx(() => NumberGroup(num: dateTime.value.second)),
      ],
    );
  }
}
