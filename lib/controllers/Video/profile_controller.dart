import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  Future<File?> selectImageOfController(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) {
      return null;
    }

    final croppedImageFile = cropImage(pickedFile);
    return croppedImageFile;
  }

  Future<File?> cropImage(XFile file) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 20,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (croppedImage == null) {
      return null;
    }

    return croppedImage;
  }
}
