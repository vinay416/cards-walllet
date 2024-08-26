import 'package:flutter/material.dart';

class CardValidateButton extends StatelessWidget {
  const CardValidateButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.black),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
        onPressed: onTap,
        child: const Text(
          "Validate",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
