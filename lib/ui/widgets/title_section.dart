import 'package:flutter/material.dart';

import 'size_config.dart';

class TitleSection extends StatelessWidget {
  final Widget title;
  final Widget? actions;
  final double height;
  const TitleSection({
    Key? key,
    required this.title,
    this.actions,
    this.height = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Sizer.getProportionateScreenHeight(context, height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: title),
                if (actions != null) actions!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
