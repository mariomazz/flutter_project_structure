import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../authorities/authority_provider.dart';
import 'favorite_provider.dart';
import 'profile_provider.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ListenableProvider<ProfileProvider>(
      create: (context) => ProfileProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
    ListenableProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
    ListenableProvider<AuthorityProvider>(
      create: (context) => AuthorityProvider(),
      dispose: (context, provider) => provider.dispose(),
    ),
  ];
}
