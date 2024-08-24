import 'package:flutter/material.dart';
import 'package:security/card_view/basic_card.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAllCards extends StatelessWidget {
  const ShimmerAllCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          for (int i = 0; i < 5; i++) card(),
        ],
      ),
    );
  }

  Widget card() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: BasicCard(
          elevation: 5,
        ),
      ),
    );
  }
}
