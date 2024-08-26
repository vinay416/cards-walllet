import 'package:flutter/material.dart';

import 'package:security/card_view/basic_card.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/model/card_data_model.dart';
import '../../card_view/widgets/back_card_view.dart';
import '../../card_view/widgets/front_card_view.dart';

class CardView extends StatelessWidget {
  const CardView({super.key, required this.cardController, required this.data});
  final CardController cardController;
  final CardDataModel data;

  @override
  Widget build(BuildContext context) {
    return CardViewAnimation(
      enableGesture: false,
      controller: cardController,
      front: BasicCard(
        cardView: FrontCardView(cardDetails: data),
      ),
      back: BasicCard(
        cardView: BackCardView(cardDetails: data),
      ),
    );
  }
}
