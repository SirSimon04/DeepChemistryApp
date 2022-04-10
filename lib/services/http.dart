import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:async';

class HttpHelper {
  Future<void> uploadImage(
      {required Uint8List image, required String filename}) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("http://synologynas-simon.ddns.net:6666/upload"));

    final headers = {
      "Content-type": "multipart/form-data",
    };

    request.files.add(
      http.MultipartFile(
        "0",
        http.ByteStream.fromBytes(image),
        image.lengthInBytes,
        filename: filename,
      ),
    );

    request.headers.addAll(headers);

    await request.send();
  }
}
