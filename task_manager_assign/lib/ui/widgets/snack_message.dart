import 'package:flutter/material.dart';

void showSnackMessage(BuildContext context, String message,
    [bool issError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: issError ? Colors.red : null,
    ),
  );
}
