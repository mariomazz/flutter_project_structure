import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TextI extends StatelessWidget {
  const TextI({
    Key? key,
    required this.title,
    this.style,
    this.size = TextSize.normal,
    this.maxLines = 1,
    this.textAlign,
  }) : super(key: key);

  final String title;
  final TextStyle? style;
  final TextSize size;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppTheme.textPrimary,
      fontSize: size.value,
    );
    return Text(
      maxLines: maxLines,
      title,
      style: style ?? textStyle,
      textAlign: textAlign,
    );
  }
}

enum TextSize { small, normal, large }

extension TextSizeExtension on TextSize {
  double? get value {
    if (name == "small") {
      return 12.0;
    }
    if (name == "normal") {
      return 17.0;
    }
    if (name == "large") {
      return 22.0;
    }
    return null;
  }
}
