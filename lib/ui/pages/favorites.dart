import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/favorite_provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites>
    with AutomaticKeepAliveClientMixin<Favorites> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<FavoriteProvider>(
      builder: (ctx, provider, _) {
        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
