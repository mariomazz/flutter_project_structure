import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../common/models/attachment_base.dart';
import '../http/http_service.dart';
import '../http/models/http_request.dart';

class FileManagerService {
  Future<List<File>?> selectImagesFromGallery() async {
    final images = await ImagePicker().pickMultiImage();

    if (images == null) {
      return null;
    }

    return images.map((e) => File(e.path)).toList();
  }

  Future<File?> selectImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  Future<File?> imageFromCamera() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);

    if (photo == null) {
      return null;
    }

    return File(photo.path);
  }

  Future<List<File>?> selectFilesFromMemory() async {
    final pickFiles = await FilePicker.platform.pickFiles();
    if (pickFiles == null) {
      return null;
    }

    final filesNullabe = pickFiles.files
        .map((e) => e.path != null ? File(e.path!) : null)
        .toList();
    final a = <File>[];

    for (var e in filesNullabe) {
      if (e != null) {
        a.add(e);
      }
    }

    return a;
  }

  Future<AttachmentBase?> uploadMultipartFile(HttpRequestBase request) async {
    final response = await Http().post(req: request);

    try {
      return AttachmentBase.fromMap(response.data);
    } catch (e) {
      return null;
    }
  }
}
