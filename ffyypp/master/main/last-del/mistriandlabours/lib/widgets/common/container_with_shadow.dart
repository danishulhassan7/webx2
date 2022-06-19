import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/theme_helper.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: ThemeHelper().inputBoxDecorationShaddow(),
    );
  }
}
