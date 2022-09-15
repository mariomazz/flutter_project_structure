import 'dart:convert';

class AttachmentBase {
  final String? id;
  final String fileName;
  final String? mimeType;
  AttachmentBase({
    this.id,
    required this.fileName,
    this.mimeType,
  });

  AttachmentBase copyWith({
    String? id,
    String? fileName,
    String? mimeType,
  }) {
    return AttachmentBase(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fileName': fileName,
      'mimeType': mimeType,
    };
  }

  factory AttachmentBase.fromMap(Map<String, dynamic> map) {
    return AttachmentBase(
      id: map['id'],
      fileName: map['fileName'] ?? '',
      mimeType: map['mimeType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentBase.fromJson(String source) =>
      AttachmentBase.fromMap(json.decode(source));

  @override
  String toString() =>
      'AttachmentBase(id: $id, fileName: $fileName, mimeType: $mimeType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttachmentBase &&
        other.id == id &&
        other.fileName == fileName &&
        other.mimeType == mimeType;
  }

  @override
  int get hashCode => id.hashCode ^ fileName.hashCode ^ mimeType.hashCode;
}
