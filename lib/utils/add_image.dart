import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future postImageCamera(Function function(File file)) async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

  final dir = await path_provider.getTemporaryDirectory();
  final targetPath = dir.absolute.path + "/temp.jpg";

  final fileCompressed =
      await compressAndGetFile(File(pickedFile.path), targetPath);
  function(fileCompressed);
}

Future postImageGallery(Function function(File file)) async {
  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

  final dir = await path_provider.getTemporaryDirectory();
  final targetPath = dir.absolute.path + "/temp.jpg";

  final fileCompressed =
      await compressAndGetFile(File(pickedFile.path), targetPath);
  function(fileCompressed);
}

Future<File> compressAndGetFile(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 40,
    rotate: 0,
  );

  return result;
}
