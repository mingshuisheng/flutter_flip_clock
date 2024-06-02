import 'package:flipclock/colors.dart';
import 'package:flipclock/sizes.dart';
import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';

class Splitter extends BaseStatelessWidget {
  const Splitter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Dot(), SplitterGap(), Dot()],
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    final size = dotSize(MediaQuery.of(context).size);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        color: Colors.white,
      ),
    );
  }
}

class SplitterGap extends StatelessWidget {
  const SplitterGap({super.key});

  @override
  Widget build(BuildContext context) {
    final size = splitterGapSize(MediaQuery.of(context).size);
    return SizedBox(height: size);
  }
}
