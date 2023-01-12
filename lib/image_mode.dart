import 'dart:io';
import 'package:flutter/material.dart';
import 'package:activity5/image_mod.dart';
import 'package:activity5/permission_handler/image_permissions.dart';
import 'package:activity5/pick_file.dart';
import 'image_loaded.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> with WidgetsBindingObserver {
  late final ImageMod _model;
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    _model = ImageMod();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _detectPermission &&
        (_model.imageSect == ImageSect.noStoragePermissionPermanent)) {
      _detectPermission = false;
      _model.requestFilePermission();
    } else if (state == AppLifecycleState.paused &&
        _model.imageSect == ImageSect.noStoragePermissionPermanent) {
      _detectPermission = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var ChangeNotifierProvider;

    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<ImageMod>(
        builder: (context, model, child) {
          Widget widget;

          switch (model.imageSect) {
            case ImageSect.noStoragePermission:
              widget = ImagePermissions(
                  isPermanent: false, onPressed: _checkPermissionsAndPick);
              break;
            case ImageSect.noStoragePermissionPermanent:
              widget = ImagePermissions(
                  isPermanent: true, onPressed: _checkPermissionsAndPick);
              break;
            case ImageSect.browseFiles:
              widget = PickFile(onPressed: _checkPermissionsAndPick);
              break;
            case ImageSect.imageLoad:
              widget = ImageLoaded(file: _model.file!);
              break;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Handle permissions'),
            ),
            body: widget,
          );
        },
      ),
    );
  }


  Future<void> _checkPermissionsAndPick() async {
    final hasFilePermission = await _model.requestFilePermission();
    if (hasFilePermission) {
      try {
        await _model.pickFile();
      } on Exception catch (e) {
        debugPrint('Error when picking a file: $e');
        // Show an error to the user if the pick file failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred when picking a file'),
          ),
        );
      }
    }
  }
}