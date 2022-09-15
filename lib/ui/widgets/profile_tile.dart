import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final dynamic Function()? onTap;
  final IconData? icon;
  const ProfileTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: AppTheme.white,
      child: ListTile(
        onTap: () async {
          await onTap?.call();
        },
        leading: Icon(
          icon,
          color: AppTheme.primary,
          size: 30.0,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textPrimaryLight,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios) : null,
      ),
    );
  }
}
