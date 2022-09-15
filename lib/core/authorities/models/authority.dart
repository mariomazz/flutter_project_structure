import 'dart:convert';

class Authority {
  final bool isDefault;
  final String tenantId;
  final int authorityId;
  final String? name;
  final String? imageUrl;
  final String? logoUrl;
  final double latitude;
  final double longitude;
  Authority({
    required this.isDefault,
    required this.tenantId,
    required this.authorityId,
    this.name,
    this.imageUrl,
    this.logoUrl,
    required this.latitude,
    required this.longitude,
  });

  Authority copyWith({
    bool? isDefault,
    String? tenantId,
    int? authorityId,
    String? name,
    String? imageUrl,
    String? logoUrl,
    double? latitude,
    double? longitude,
  }) {
    return Authority(
      isDefault: isDefault ?? this.isDefault,
      tenantId: tenantId ?? this.tenantId,
      authorityId: authorityId ?? this.authorityId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDefault': isDefault,
      'tenantId': tenantId,
      'authorityId': authorityId,
      'name': name,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static List<Authority> fromList(List<dynamic> data) {
    return data.map((e)=>Authority.fromMap(e)).toList();
  }

  factory Authority.fromMap(Map<String, dynamic> map) {
    return Authority(
      isDefault: map['isDefault'] ?? false,
      tenantId: map['tenantId'] ?? '',
      authorityId: map['authorityId']?.toInt() ?? 0,
      name: map['name'],
      imageUrl: map['imageUrl'],
      logoUrl: map['logoUrl'],
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Authority.fromJson(String source) =>
      Authority.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Authority(isDefault: $isDefault, tenantId: $tenantId, authorityId: $authorityId, name: $name, imageUrl: $imageUrl, logoUrl: $logoUrl, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Authority &&
        other.isDefault == isDefault &&
        other.tenantId == tenantId &&
        other.authorityId == authorityId &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.logoUrl == logoUrl &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return isDefault.hashCode ^
        tenantId.hashCode ^
        authorityId.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        logoUrl.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
