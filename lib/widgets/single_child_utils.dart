import 'package:flipclock/function_utils.dart';
import 'package:flipclock/types.dart';
import 'package:flutter/cupertino.dart';

import 'base_stateless_widget.dart';

class SingleChildComposeBuilder extends BaseStatelessWidget {
  const SingleChildComposeBuilder({
    super.key,
    required this.composeWidget,
    required super.child,
  });

  final List<SingleChildBuilder> composeWidget;

  @override
  Widget build(BuildContext context) {
    return compose(composeWidget)(child);
  }
}

abstract class BaseSingleChildCompose extends BaseStatelessWidget {
  const BaseSingleChildCompose({super.key, required super.child});

  List<SingleChildBuilder> getComposeWidget();

  @override
  Widget build(BuildContext context) {
    return compose(getComposeWidget())(child);
  }
}
