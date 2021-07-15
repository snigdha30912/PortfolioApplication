import 'dart:io';

import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:template_basic1/profile_viewer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../database.dart';

class ImageUtil {
  final picker = ImagePicker();
  Future<File> imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    // setState(() {
    //   _image = File(pickedFile.path);
    //   show = !show;
    // });
    File croppedImage =
        pickedFile != null ? await _cropImage(pickedFile.path) : null;

    if (croppedImage != null) {
      return croppedImage;
    }

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File> imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);

    debugPrint("picking image from gallery");
    File croppedImage =
        pickedFile != null ? await _cropImage(pickedFile.path) : null;

    if (croppedImage != null) {
      return croppedImage;
    }

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    return croppedImage;
  }
}
