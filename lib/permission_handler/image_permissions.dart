import 'dart:html';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePermissions extends StatelessWidget {
  final bool isPermanent;

  var onPressed;


  const ImagePermissions({
    Key? key,
    required this.isPermanent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: Text('Read files permission',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 14.0,
              top: 28.0,
              right: 18.0,
            ),
            child: const Text('Requesting to have access in your local storage.',
              textAlign: TextAlign.center,
            ),
          ),
          if (isPermanent)
            Container(
              padding: const EdgeInsets.only(
                left: 14.0,
                top: 28.0,
                right: 18.0,
              ),
              child: const Text('Requesting to have access in your system settings.',
                textAlign: TextAlign.center,
              ),
            ),
          Container(
            padding: const EdgeInsets.only(
                left: 14.0,
                top: 28.0,
                right: 18.0,
                bottom: 28.0),
            child: ElevatedButton(
              child: Text(isPermanent ? 'Open settings' : 'Allow access'),
              onPressed: () => isPermanent ? openAppSettings() : onPressed(),
            ),
          ),
        ],
      ),
    );
  }
}
