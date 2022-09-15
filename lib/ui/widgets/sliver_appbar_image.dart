import 'package:flutter/material.dart';
import '../../core/authorities/authority_provider.dart';

class SliverAppBarImage extends StatelessWidget {
  final Widget? child;
  const SliverAppBarImage({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: AspectRatio(
        aspectRatio:1/1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                AuthorityProvider().authority?.logoUrl ??
                    'https://www.outletarredamento.it/images/pavimenti/ceramica-so-tiles-collection-lapis-100x300---gres-sottile-tinta-unita-prezzi-scontati_n1_872008.webp',
              ),
            ),
          ),
          child: child,
        ),
      ),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
    );
  }
}
