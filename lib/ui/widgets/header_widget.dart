import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';

class HeaderWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget title;
  final Widget? subtitle;
  final Widget? action;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const HeaderWidget({
    Key? key,
    this.height = 122,
    this.width = double.infinity,
    required this.title,
    this.subtitle,
    this.action,
    this.backgroundColor = AppTheme.background,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: Sizer.getProportionateScreenHeight(context, height),
      decoration: BoxDecoration(color: backgroundColor),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (subtitle != null)
                    SizedBox(
                      height: Sizer.getProportionateScreenHeight(context, 16),
                    ),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: action,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
