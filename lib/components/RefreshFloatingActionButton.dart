import 'package:flutter/material.dart';
import 'package:userdetailsapp/uikit/uiColors.dart';

class RefreshFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RefreshFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed, // Set the onPressed callback
      backgroundColor: uiColors.random,
      child: const Icon(
        Icons.refresh_rounded,
        color: uiColors.selected,
        size: 30.0,
      ),
    );
  }
}
