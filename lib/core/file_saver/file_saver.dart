import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import '../../ui/widgets/pop_up/pop_up.dart';
import '../http/http_service.dart';
import '../http/models/header_type.dart';
import '../http/models/http_request.dart';
import '../path/path_manager.dart';

class FileSaverService {
  Future<void> saveFileWithUrl(String url, String fileName,
      {PopUpController? loadingController}) async {
    loadingController?.show();

    final path = await PathManager.getMainDirectory(fileName);

    await Http().download(
      req: HttpRequestDownloadingFile(
        savePath: path,
        request: HttpRequestBase(
          point: url,
          baseUrl: false,
          headerType: HeaderType.notAuthorize,
        ),
      ),
    );

    loadingController?.close();

    return;
  }

  Future<void> saveFile(File file, {PopUpController? loadingController}) async {
    loadingController?.show();
    final baseName = basename(file.path);
    final path = await PathManager.getMainDirectory(baseName);
    final File saveFile = File(path);
    await saveFile.writeAsBytes(await file.readAsBytes());
    loadingController?.close();
  }

  Future<void> saveFileFromBytes(Future<Uint8List> bytes,
      {PopUpController? loadingController}) async {
    return await saveFile(
      File.fromRawPath(await bytes),
      loadingController: loadingController,
    );
  }
}
