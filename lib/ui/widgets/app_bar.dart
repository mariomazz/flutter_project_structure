import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'main_button.dart';
import 'pop_button.dart';
import 'size_config.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final dynamic Function() leadingAction;
  final List<Widget>? actions;
  const MainAppBar({
    Key? key,
    required this.text,
    required this.leadingAction,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.5,
      leading: PopButton(
        onTap: () async {
          await leadingAction.call();
        },
        backgroundColor: AppTheme.mainAppBar,
      ),
      backgroundColor: AppTheme.mainAppBar,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainButton(
            disableSplash: true,
            height: Sizer.getProportionateScreenHeight(context, 34),
            radius: Sizer.getProportionateScreenRadius(context, 100),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: Sizer.getProportionateScreenTextSize(context, 18),
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textLight,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            width: Sizer.getProportionateScreenHeight(context, 157),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
