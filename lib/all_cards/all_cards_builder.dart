import 'package:flutter/material.dart';
import 'package:security/card_view/basic_card.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/card_view/widgets/back_card_view.dart';
import 'package:security/card_view/widgets/front_card_view.dart';
import 'package:security/model/card_data_model.dart';

class AllCardsBuilder extends StatelessWidget {
  const AllCardsBuilder({super.key, required this.cards});
  final List<CardDataModel> cards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CardBuilderItem(
            cardDetails: cards[index],
          ),
        );
      },
    );
  }
}

class CardBuilderItem extends StatelessWidget {
  const CardBuilderItem({super.key, required this.cardDetails});
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    return CardViewAnimation(
      enableGesture: true,
      controller: CardController(),
      front: BasicCard(
        cardView: FrontCardView(
          cardDetails: cardDetails,
        ),
      ),
      back: BasicCard(
        cardView: BackCardView(
          cardDetails: cardDetails,
        ),
      ),
    );
  }
}
