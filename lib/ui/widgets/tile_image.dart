import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'progress.dart';
import 'size_config.dart';

class TileImage extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String? subtitle;
  final dynamic Function()? onTap;
  final bool dismissIcon;
  final Widget? actionIcon;
  final Color? shadowColor;

  const TileImage({
    Key? key,
    this.imageUrl,
    required this.title,
    this.subtitle,
    this.onTap,
    this.dismissIcon = false,
    this.actionIcon,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5,
      ),
      child: InkWell(
        onTap: () async {
          await onTap?.call();
        },
        child: Card(
          elevation: 1.5,
          shadowColor: shadowColor,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (imageUrl != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: Sizer.getProportionateScreenHeight(context, 70),
                    width: Sizer.getProportionateScreenWidth(context, 50),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (_, __) => const ProgressWidget(
                        color: AppTheme.primary,
                      ),
                      errorWidget: (_, __, ___) {
                        return const ProgressWidget();
                      },
                    ),
                  ),
                SizedBox(
                  width: Sizer.getProportionateScreenWidth(context, 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle ?? '',
                          maxLines: 3,
                        ),
                    ],
                  ),
                ),
                if (dismissIcon && actionIcon == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                if (actionIcon != null) actionIcon!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
