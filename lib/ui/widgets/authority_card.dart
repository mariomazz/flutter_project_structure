import 'package:flutter/material.dart';
import '../../core/authorities/models/authority.dart';
import '../theme/theme.dart';
import 'tile_image.dart';

class AuthorityCard extends StatelessWidget {
  final Authority authority;
  final dynamic Function()? onTap;
  const AuthorityCard({Key? key, required this.authority, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TileImage(
      imageUrl: authority.logoUrl,
      title: authority.name ?? '',
      subtitle: null,
      onTap: onTap,
      actionIcon: authority.isDefault
          ? const Icon(Icons.done, color: AppTheme.primary)
          : null,
      shadowColor: authority.isDefault ? AppTheme.primary : null,
    );
  }
}
