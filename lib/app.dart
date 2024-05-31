import 'package:flipclock/widgets/base_widget.dart';
import 'package:flipclock/widgets/time_area.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWidget(
      child: Stack(
        children: [
          TimeArea(),
        ],
      ),
    );
  }
}
