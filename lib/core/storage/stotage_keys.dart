import '../env/env.manager.dart';

class StorageKeys {
  static final _envKey = "{${EnvManager().envName}${EnvManager().clientId}}";
  static const _uniqueKey = "lahf";
  static final notificationHubKey = "notificationHub_$_uniqueKey$_envKey";
  static final String favoriteComunications =
      'favorite_comunication_$_uniqueKey$_envKey';
  static final authenticationKey = "authentication_key_$_uniqueKey$_envKey";
}
