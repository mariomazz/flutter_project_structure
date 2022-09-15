import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../http/models/json_serializable.dart';

class FilterResult<T extends JsonSerializable> implements JsonSerializable {
  final List<T> items;
  final int totalCount;

  FilterResult({
    required this.items,
    required this.totalCount,
  });

  FilterResult<T> copyWith({
    List<T>? items,
    int? totalCount,
  }) {
    return FilterResult<T>(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => x.toMap()).toList(),
      'totalCount': totalCount,
    };
  }

  factory FilterResult.fromMap(Map<String, dynamic> map) {
    return FilterResult<T>(
      items: List<T>.from(
          map['items']?.map((x) => JsonSerializable.fromMap<T>(x))),
      totalCount: map['totalCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterResult.fromJson(String source) =>
      FilterResult.fromMap(json.decode(source));

  @override
  String toString() => 'FilterResult(items: $items, totalCount: $totalCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterResult<T> &&
        listEquals(other.items, items) &&
        other.totalCount == totalCount;
  }

  @override
  int get hashCode => items.hashCode ^ totalCount.hashCode;
}
