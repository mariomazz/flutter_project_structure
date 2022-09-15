import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ChipWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final dynamic Function()? onTap;
  const ChipWidget({
    Key? key,
    required this.text,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : AppTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.primary)),
        child: Material(
          color: AppTheme.transparent,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 10, left: 18, right: 18),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: isSelected ? AppTheme.white : AppTheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
