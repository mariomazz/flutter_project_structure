abstract class JsonSerializable {
  Map<String, dynamic> toMap();
  static T fromMap<T extends JsonSerializable>(Map<String, dynamic> data) =>
      _JsonSerializableFromMap.getFromMap(T, data) as T;
}

class _JsonSerializableFromMap {
  static final Map<Type, JsonSerializable Function(Map<String, dynamic> data)>
      _fromMapImplementations = {}; // add fromMap here

  static JsonSerializable getFromMap(Type t, Map<String, dynamic> data) {
    final fromMap = _fromMapImplementations[t];
    if (fromMap == null) {
      throw Exception("Type Error");
    }
    return fromMap.call(data);
  }
}
