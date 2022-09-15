import 'package:flutter/material.dart';
import '../http/models/header_type.dart';
import '../http/models/http_request.dart';
import 'models/authority.dart';
import '../http/http_service.dart';

class AuthorityProvider extends ChangeNotifier {
  int? get authorityId => authority?.authorityId;
  Authority? get authority {
    Authority? authority;

    if (_authorities != null && _authorities!.isNotEmpty) {
      _authorities?.forEach((element) {
        if (element.isDefault) {
          authority = element;
          return;
        }
      });
      if (authority == null) {
        return _authorities?.first;
      }
      return authority;
    }
    return null;
  }

  List<Authority>? _authorities;
  List<Authority>? get authorities => _authorities;

  bool get isLoadingAuthorities => authority == null;

  AuthorityProvider._create();

  static final AuthorityProvider _instance = AuthorityProvider._create();

  factory AuthorityProvider() {
    return _instance;
  }

  Future<void> fetchAuthorities() async {
    final response = await Http().get(
      req: HttpRequestBase(
        point: "profiles/authorities",
        headerType: HeaderType.authorize,
      ),
    );
    return _setAuthorities(Authority.fromList(response.data));
  }

  Future<void> _setAuthority(int authorityId) async {
    await Http().put(
      req: HttpRequestBase(
        point: "profiles/authorities/${authorityId.toString()}",
        headerType: HeaderType.authorize,
      ),
    );
    await fetchAuthorities();
  }

  void _setAuthorities(List<Authority> authorities) {
    _authorities = authorities;
    notifyListeners();
  }

  Future<void> select(int authorityId) async {
    await _setAuthority(authorityId);
  }
}
