// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:security/card_view/basic_card.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

import '../card_view/widgets/back_card_view.dart';
import '../card_view/widgets/front_card_view.dart';

class CardView extends StatelessWidget {
  const CardView({super.key, required this.cardController});
  final CardController cardController;

  @override
  Widget build(BuildContext context) {
    return CardViewAnimation(
      enableGesture: false,
      controller: cardController,
      front: buildFront(),
      back: buildBack(),
    );
  }

  Widget buildFront() {
    return Selector<CardsViewModel, CardDataModel>(
      selector: (p0, p1) => p1.newCard,
      builder: (context, data, _) {
        return BasicCard(
          cardView: FrontCardView(cardDetails: data),
        );
      },
    );
  }

  Widget buildBack() {
    return Selector<CardsViewModel, CardDataModel>(
      selector: (p0, p1) => p1.newCard,
      builder: (context, data, _) {
        return BasicCard(
          cardView: BackCardView(cardDetails: data),
        );
      },
    );
  }
}
