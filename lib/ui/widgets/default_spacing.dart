import 'package:flutter/material.dart';

class DefaultSpacing extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;
  const DefaultSpacing({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(7),
    this.padding = const EdgeInsets.all(7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
