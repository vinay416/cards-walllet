import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({
    super.key,
    this.cardView,
    this.elevation = 10,
  });
  final Widget? cardView;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        margin: const EdgeInsets.all(0),
        child: cardView,
      ),
    );
  }
}
