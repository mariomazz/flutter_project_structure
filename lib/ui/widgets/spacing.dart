import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final ExtendValue spacing;
  const Spacing({Key? key, this.spacing = ExtendValue.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing.getDimension(),
      width: spacing.getDimension(),
    );
  }
}

enum ExtendValue { min, normal, max }

extension ExExtendValue on ExtendValue {
  double getDimension() {
    switch (this) {
      case ExtendValue.max:
        return 20;
      case ExtendValue.min:
        return 10;
      case ExtendValue.normal:
        return 15;
      default:
        return 10;
    }
  }
}
