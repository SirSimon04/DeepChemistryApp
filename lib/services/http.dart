import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:async';

class HttpHelper {
  final String ngrokUrl = "localhost:5000";

  Future<void> uploadImage(
      {required Uint8List image, required String filename}) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("http://219d-84-191-203-1.ngrok.io/upload"));

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
