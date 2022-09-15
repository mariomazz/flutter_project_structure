import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String text;
  final bool centerTitle;
  final Widget child;
  final Function? methodrefreshPage;
  final Widget action;

  const SliverAppBarWidget({
    Key? key,
    required this.text,
    this.centerTitle = false,
    required this.child,
    this.methodrefreshPage,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/smartpa-80.png',
            height: 60,
            width: 60,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'lato',
                fontSize: 20,
                letterSpacing: 0.27,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          action,
        ],
      ),
      snap: true,
      forceElevated: true,
      floating: true,
      pinned: true,
      stretch: true,
      backgroundColor: AppTheme.background,
      centerTitle: centerTitle,
      expandedHeight: 2.5 * kToolbarHeight,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: Sizer.getProportionateScreenHeight(context, 85)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16),
                child: SizedBox(
                  height: Sizer.getProportionateScreenHeight(context, 45),
                  width: double.infinity,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
