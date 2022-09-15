import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/autentication/auth_provider.dart';
import '../../../core/language/it.dart';
import '../size_config.dart';

class ShowDialog {
  static Future<void> image(BuildContext context, String imageUrl) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: Sizer.getProportionateScreenWidth(context, 300),
            height: Sizer.getProportionateScreenHeight(context, 600),
            child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill),
          ),
        );
      },
    );
  }

  static Future<void> logoutDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            title: const Text(ItL.profileLogoutAlertTitle),
            content: const Text(ItL.logoutConfirm),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(ItL.alertCancelLabel),
              ),
              TextButton(
                onPressed: () async {
                  await AuthProvider().logout();
                },
                child: const Text(ItL.alertConfirmLabel),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: const Text(ItL.profileLogoutAlertTitle),
            content: const Text(ItL.logoutConfirm),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(ItL.alertCancelLabel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: const Text(ItL.alertConfirmLabel),
                onPressed: () async {
                  await AuthProvider().logout();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
