import 'package:platforms_auth_service/core/models/auth_configurations.dart';
import '../../env/env.manager.dart';

class AuthenticationConfigurations {
  static AuthConfigurations authConfigurations = AuthConfigurations(
    clientId: EnvManager().clientId,
    tenantId: EnvManager().tenantId,
    redirectUrl: EnvManager().redirectUrl,
    issuer: EnvManager().issuer,
    discoveryUrl: EnvManager().discoveryUrl,
    postLogoutRedirectUrl: EnvManager().postLogOutRedirectUrl,
    authorizationEndpoint: EnvManager().authorizationEndpoint,
    tokenEndpoint: EnvManager().tokenEndpoint,
    endSessionEndpoint: EnvManager().endSessionPoint,
    additionalParameter: EnvManager()
        .loginAdditionalParameter
        .map((k, v) => MapEntry(k, v.toString())),
    scopes: EnvManager().loginScopes,
    clientSecret: "secret",
    promptValues: ["login"],
  );
}
