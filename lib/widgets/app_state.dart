import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'base_stateless_widget.dart';

class AppStateController extends GetxController {}

class AppState extends BaseStatelessWidget {
  AppState({super.key, super.child});

  final appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

AppStateController getAppStateController() {
  return Get.find();
}
