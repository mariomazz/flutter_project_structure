import 'package:flutter/material.dart';

class NoOverscrollIndicator extends StatelessWidget {
  const NoOverscrollIndicator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: child,
    );
  }
}
