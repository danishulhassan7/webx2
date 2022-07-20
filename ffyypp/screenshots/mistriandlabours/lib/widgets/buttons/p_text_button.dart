import 'package:flutter/material.dart';

class PTextButton extends StatelessWidget {
  const PTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      onPressed: onPressed,
    );
  }
}
