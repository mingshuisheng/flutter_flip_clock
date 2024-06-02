import 'package:flipclock/sizes.dart';
import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flipclock/widgets/number.dart';
import 'package:flutter/cupertino.dart';

class NumberGroup extends BaseStatelessWidget {
  const NumberGroup({super.key, this.num = 0, this.max = 59});

  final int num;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Number(
          num: num ~/ 10,
          max: max ~/ 10,
        ),
        const NumbGroupGap(),
        Number(num: num % 10, max: max ~/ 10 == 0 ? max % 10 : 9),
      ],
    );
  }
}

class NumbGroupGap extends StatelessWidget{
  const NumbGroupGap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: numberGroupGapSize(MediaQuery.of(context).size));
  }
}
