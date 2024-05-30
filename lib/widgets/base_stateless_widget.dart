import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key, this.child});
  final Widget? child;
}