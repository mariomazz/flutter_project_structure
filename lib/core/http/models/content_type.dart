enum ContentTypeI { json, multipartFormData }

extension ContentTypeExt on ContentTypeI {
  Map<String, String> getHeader() {
    switch (this) {
      case ContentTypeI.json:
        return <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        };
      case ContentTypeI.multipartFormData:
        return <String, String>{"Content-Type": "multipart/formdata"};
      default:
        return <String, String>{};
    }
  }
}
