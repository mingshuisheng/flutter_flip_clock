import 'package:flipclock/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Container(
        color: Colors.red,
        child: Stack(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.resizeDown,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 150,
                  height: 150,
                  color: Color(0xaa0000ff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
