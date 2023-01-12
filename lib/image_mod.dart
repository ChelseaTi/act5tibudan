import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';


enum ImageSect {
  noStoragePermission, //tiz section is denied
  noStoragePermissionPermanent, //tiz one is permanently denied
  browseFiles, //tiz will allow users to pick files
  imageLoad, //users picked file and to be display
}

class ImageMod extends ChangeNotifier {
  ImageSect _imageSect = ImageSect.browseFiles;

  ImageSect get imageSect => _imageSect;

  set imageSect(ImageSect value) {
    if (value != _imageSect){
      _imageSect = value;
      notifyListeners();
    }
  }

    File? file;

    Future<bool> requestFilePermission() async {
      PermissionStatus result;
      if (Platform.isAndroid) {
        result = await Permissions.storage.request();
      } else {
        result = await Permissions.photos.request();
      }
      if (result.isGranted) {
        imageSect = imageSect.browseFiles;
        return true;
      } else if (Platform.isIOS || result.isPermanentlyDenied) {
        imageSect = imageSect.noStoragePermissionPermanent;
      } else {
        imageSect = imageSect.noStoragePermission;
      }
        return false;
    }


    Future<void> pickFile() async{
      final filePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);


      if (result != null &&
          result.files.isNotEmpty &&
          result.files.single.path != null) {
        file = File (result.files.single.path!);
        imageSect = ImageSect.imageLoad;
      }
    }
}