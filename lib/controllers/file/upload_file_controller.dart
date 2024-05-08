import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:testapp/utils/api_config.dart';

class UploadFileController extends GetxController {
  final uploadStatus = RxString('');

  Future<String?> uploadFile(File file) async {
    try {
      uploadStatus.value = 'Uploading...';
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.attachmentApiEndpointUri),
      );

      final mimeType = lookupMimeType(file.path);
      final fileStream = http.ByteStream(file.openRead());
      final length = await file.length();

      final multipartFile = http.MultipartFile(
        'files',
        fileStream,
        length,
        filename: path.basename(file.path),
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartFile);

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final uploadedFilesData = jsonDecode(respStr)['files'];
        final uploadedFileId = uploadedFilesData.first['id'];
        uploadStatus.value = 'Upload successful!';
        return uploadedFileId;
      } else {
        uploadStatus.value = 'Upload failed: ${response.reasonPhrase}';
        return null;
      }
    } catch (e) {
      print(e);
      uploadStatus.value = 'Upload failed: $e';
      return null;
    }
  }

  Future<List<String>> uploadFiles(List<File> files) async {
    try {
      uploadStatus.value = 'Uploading...';
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.attachmentApiEndpointUri),
      );

      for (final file in files) {
        final mimeType = lookupMimeType(file.path);
        final fileStream = http.ByteStream(file.openRead());
        final length = await file.length();

        final multipartFile = http.MultipartFile(
          'files',
          fileStream,
          length,
          filename: path.basename(file.path),
          contentType: MediaType.parse(mimeType!),
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final uploadedFilesData = jsonDecode(respStr)['files'];
        final uploadedFileIds = List<String>.from(
            uploadedFilesData.map((file) => file['id']));
        uploadStatus.value = 'Upload successful!';
        return uploadedFileIds;
      } else {
        uploadStatus.value = 'Upload failed: ${response.reasonPhrase}';
        return [];
      }
    } catch (e) {
      print(e);
      uploadStatus.value = 'Upload failed: $e';
      return [];
    }
  }
}