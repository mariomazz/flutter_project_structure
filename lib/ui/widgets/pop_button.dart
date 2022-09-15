import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';

class PopButton extends StatelessWidget {
  final dynamic Function() onTap;
  final Color backgroundColor;
  const PopButton(
      {Key? key, required this.onTap, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await onTap.call();
      },
      child: SizedBox(
        height: Sizer.getProportionateScreenHeight(context, 40),
        width: Sizer.getProportionateScreenWidth(context, 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            Sizer.getProportionateScreenWidth(context, 50),
          ),
          child: Container(
            height: Sizer.getProportionateScreenHeight(context, 30),
            width: Sizer.getProportionateScreenWidth(context, 30),
            color: backgroundColor,
            child: Icon(
              color: AppTheme.iconPrimary,
              Icons.arrow_back,
              size: Sizer.getProportionateScreenWidth(context, 25),
            ),
          ),
        ),
      ),
    );
  }
}
