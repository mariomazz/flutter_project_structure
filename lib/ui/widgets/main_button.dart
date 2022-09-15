import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';

class MainButton extends StatelessWidget {
  final dynamic Function()? onTap;
  final Widget title;
  final double width;
  final double height;
  final double radius;
  final bool disableSplash;

  const MainButton({
    Key? key,
    this.onTap,
    required this.title,
    required this.width,
    required this.height,
    required this.radius,
    this.disableSplash = false,
  }) : super(key: key);

  Widget getButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppTheme.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            
            borderRadius: BorderRadius.all(
              Radius.circular(
                  Sizer.getProportionateScreenRadius(context, radius)),
            ),
          ),
        ),
      ),
      onPressed: () async {
        await onTap?.call();
      },
      child: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: disableSplash
          ? BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(
                    Sizer.getProportionateScreenRadius(context, radius)),
              ),
            )
          : null,
      width: Sizer.getProportionateScreenWidth(context, width),
      height: Sizer.getProportionateScreenHeight(context, height),
      child: disableSplash ? title : getButton(context),
    );
  }
}

