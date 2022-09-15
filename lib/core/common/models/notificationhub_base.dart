import 'dart:convert';

class NotificationhubBase {
  final String registrationId;

  NotificationhubBase({
    required this.registrationId,
  });

  NotificationhubBase copyWith({
    String? registrationId,
  }) {
    return NotificationhubBase(
      registrationId: registrationId ?? this.registrationId,
    );
  }

  factory NotificationhubBase.fromMap(Map<String, dynamic> map) {
    return NotificationhubBase(
      registrationId: map['registrationId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationhubBase.fromJson(String source) =>
      NotificationhubBase.fromMap(json.decode(source));

  @override
  String toString() => 'NotificationhubBase(registrationId: $registrationId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationhubBase &&
        other.registrationId == registrationId;
  }

  @override
  int get hashCode => registrationId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'registrationId': registrationId,
    };
  }
}
