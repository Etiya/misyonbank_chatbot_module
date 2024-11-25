import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({
    super.key,
    this.errorText,
  });
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(color: Colors.red),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(errorText!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
