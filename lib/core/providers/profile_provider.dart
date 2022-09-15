import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../ui/widgets/pop_up/pop_up.dart';
import '../common/models/user_logged.dart';
import '../env/env.manager.dart';
import '../file_manager/file_manager.dart';
import '../http/http_service.dart';
import '../http/models/content_type.dart';
import '../http/models/http_request.dart';

class ProfileProvider extends ChangeNotifier {
  final PopUpController _loadingController = PopUpController();
  PopUpController get loadingController => _loadingController;

  // avatar

  Future<bool> changeAvatarAndUpdateProfile() async {
    final FileManagerService fileManager = FileManagerService();
    final image = await fileManager.selectImageFromGallery();

    if (image != null) {
      await _uploadUserAvatar(file: image);
      return true;
    }
    return false;
  }

  Future<void> _uploadUserAvatar({required File file}) async {
    await Http().post(
      req: HttpRequestBase(
        point: "${EnvManager().baseUrlProfile}Profile/avatar",
        content: ContentTypeI.multipartFormData,
        dataJsonEncode: false,
        baseUrl: false,
        data: FormData.fromMap({
          "avatar": await MultipartFile.fromFile(file.path),
        }),
      ),
    );
    await loadUserLogged();
  }

  UserLogged? _user;

  Future<void> loadUserLogged() async {
    final response = await Http().get(req: HttpRequestBase(point: 'profiles'));
    final UserLogged user = UserLogged.fromJson(response.data);

    _setUser(user);
  }

  void _setUser(UserLogged? user) {
    _user = user;
    notifyListeners();
  }

  UserLogged? get user => _user;

  String get userBaseInfo {
    return '${_user?.lastName ?? ""} ${_user?.firstName ?? ""}';
  }

  String get surname => _user?.firstName ?? '';
  String get email => _user?.email ?? '';
}
