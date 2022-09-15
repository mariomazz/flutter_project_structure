abstract class BaseConfig {
  String get envName;
  String get baseUrl;
  String get baseUrlCore;
  String get loginBaseUrl;
  String get baseUrlProfile;
  List<String> get loginScopes;
  String get tenantId;
  String get clientId;
  String get redirectUrl;
  String get issuer;
  String get discoveryUrl;
  String get postLogOutRedirectUrl;
  String get authorizationEndpoint;
  String get tokenEndpoint;
  String get endSessionPoint;
  String get privacyUrl;
  String get notificationHubUserAgent;
  Map<String, dynamic> get loginAdditionalParameter;
}
