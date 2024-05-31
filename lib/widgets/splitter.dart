import 'package:flipclock/colors.dart';
import 'package:flipclock/widgets/base_stateless_widget.dart';
import 'package:flutter/cupertino.dart';

class Splitter extends BaseStatelessWidget {
  const Splitter({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 10 / 710;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Dot(size: width), SizedBox(height: width * 2), Dot(size: width)],
    );
  }
}

class Dot extends BaseStatelessWidget {
  const Dot({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
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
