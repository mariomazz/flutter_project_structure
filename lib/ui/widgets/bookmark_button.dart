import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/favorite_provider.dart';
import '../theme/theme.dart';
import 'resolve_snapshot.dart';
import 'size_config.dart';

class BookmarkButton extends StatelessWidget {
  final int communicationId;
  final Future<void> Function() onTap;
  const BookmarkButton({
    Key? key,
    required this.onTap,
    required this.communicationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: Sizer.getProportionateScreenWidth(context, 30),
          height: Sizer.getProportionateScreenHeight(context, 30),
          child: Consumer<FavoriteProvider>(
            builder: (context, provider, _) {
              return FutureBuilder<bool>(
                future: Future.value(true),
                builder: (context, snapshot) => ResolveSnapshot<bool>(
                  onError: const SizedBox(),
                  loading: const SizedBox(),
                  snapshot: snapshot,
                  onData: (data) {
                    return Icon(
                      color: AppTheme.iconPrimary,
                      data
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
