import 'package:flutter/material.dart';

class PickFile extends StatelessWidget {
  final VoidCallback onPressed;

  const PickFile({Key? key, required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
    child: ElevatedButton(
      child: const Text('Please Pick Your File'),
      onPressed: onPressed,
    ),
  );
}