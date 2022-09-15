import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: AppTheme.separatorColor,
          height: Sizer.getProportionateScreenHeight(context, 1),
          width: Sizer.getProportionateScreenWidth(context, 342),
        ),
      ],
    );
  }
}
