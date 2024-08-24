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
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        child: cardView,
      ),
    );
  }
}
