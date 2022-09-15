import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'notificationhub_base.dart';

class NotificationhubWrite extends NotificationhubBase {
  final String platform;
  final String installationId;
  final List<String> tags;

  NotificationhubWrite({
    required String registrationId,
    required this.platform,
    required this.installationId,
    required this.tags,
  }) : super(registrationId: registrationId);
  @override
  NotificationhubWrite copyWith({
    String? platform,
    String? installationId,
    List<String>? tags,
    String? registrationId,
  }) {
    return NotificationhubWrite(
      platform: platform ?? this.platform,
      installationId: installationId ?? this.installationId,
      tags: tags ?? this.tags,
      registrationId: registrationId ?? super.registrationId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'installationId': installationId,
      'tags': tags,
      'registrationId': super.registrationId,
    };
  }

  factory NotificationhubWrite.fromMap(Map<String, dynamic> map) {
    return NotificationhubWrite(
      platform: map['platform'] ?? '',
      installationId: map['installationId'] ?? '',
      tags: List<String>.from(map['tags']),
      registrationId: NotificationhubBase.fromMap(map).registrationId,
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory NotificationhubWrite.fromJson(String source) =>
      NotificationhubWrite.fromMap(json.decode(source));

  @override
  String toString() =>
      'NotificationhubWrite(platform: $platform, installationId: $installationId, tags: $tags, registrationId: ${super.registrationId})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationhubWrite &&
        other.platform == platform &&
        other.installationId == installationId &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode =>
      platform.hashCode ^ installationId.hashCode ^ tags.hashCode;
}
/* static const fromJsonFactory = _$NotificationhubWriteFromJson;

  factory NotificationhubWrite.fromJson(Map<String, dynamic> json) =>
      _$NotificationhubWriteFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final baseNotificationHtb = super.toJson();
    return _$NotificationhubWriteToJson(this);
  } */