import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({
    super.key,
    required this.cardView,
  });
  final Widget cardView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        child: cardView,
      ),
    );
  }
}