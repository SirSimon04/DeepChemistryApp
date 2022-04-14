import 'dart:convert';
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

  Future<List<dynamic>> getValidationImages() async {
    try {
      var response = await http
          .get(Uri.parse("http://synologynas-simon.ddns.net:5555/validate"));
      Map<String, dynamic> json = jsonDecode(response.body);

      return json[
          "images"]; //format is [{name: Methan, base64:asdf}, {name: Methan, base64:asdf},...]
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> validate(String path) async {
    try {
      await http.get(
          Uri.parse("http://synologynas-simon.ddns.net:5555/v?path=" + path));
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String path) async {
    try {
      await http.get(Uri.parse(
          "http://synologynas-simon.ddns.net:5555/delete?path=" + path));
    } catch (e) {
      print(e);
    }
  }
}
