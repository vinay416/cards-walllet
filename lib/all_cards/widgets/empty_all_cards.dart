import 'package:flutter/material.dart';

class EmptyAllCards extends StatelessWidget {
  const EmptyAllCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/wallet.png"),
        const Text(
          "No cards added yet!",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
