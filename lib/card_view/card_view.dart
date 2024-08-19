import 'package:flutter/material.dart';
import 'package:security/card_view/card_view_animation.dart';

import 'widgets/back_card_view.dart';
import 'widgets/front_card_view.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final CardController cardController = CardController();

  @override
  Widget build(BuildContext context) {
    return CardViewAnimation(
      enableGesture: true,
      controller: cardController,
      front: buildFront(),
      back: buildBack(),
    );
  }

  Widget buildFront() {
    return BasicCard(
      cardView: FrontCardView(),
    );
  }

  Widget buildBack() {
    return BasicCard(
      cardView: BackCardView(),
    );
  }
}

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
