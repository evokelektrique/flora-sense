import 'dart:io';

import 'package:flora_sense/features/identify/exceptions.dart';
import 'package:flora_sense/features/network/network_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  final ImagePicker imagePicker;

  CameraService({required this.imagePicker});

  Future<File?> takePicture() async {
    if (!await NetworkHelper.checkInternetConnectionAsync()) {
      throw Exception('No internet connection');
    }

    final bool isMobile = Platform.isAndroid || Platform.isIOS;

    if (isMobile) {
      if (await Permission.camera.isPermanentlyDenied) {
        openAppSettings();
      }

      await Permission.camera.request();
    }

    final ImageSource imageSource =
        isMobile ? ImageSource.camera : ImageSource.gallery;

    final XFile? image = await imagePicker.pickImage(source: imageSource);

    if (image == null) {
      throw IdentifyImageDiscardedException('Image discarded');
    }

    return File(image.path);
  }
}
