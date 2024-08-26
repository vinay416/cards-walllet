import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/all_cards/edit_mode/edit_mode_cards_builder.dart';
import 'package:security/card_view/basic_card.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/card_view/widgets/back_card_view.dart';
import 'package:security/card_view/widgets/front_card_view.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

class AllCardsBuilder extends StatelessWidget {
  const AllCardsBuilder({super.key, required this.cards});
  final List<CardDataModel> cards;

  @override
  Widget build(BuildContext context) {
    return Selector<CardsViewModel, bool>(
      builder: (context, isEditMode, child) {
        if (isEditMode) return EditModeCardsBuilder(cards: cards);

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 15, bottom: 80),
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
      },
      selector: (p0, p1) => p1.isEditMode,
    );
  }
}

class CardBuilderItem extends StatelessWidget {
  const CardBuilderItem({
    super.key,
    required this.cardDetails,
    this.enableGesture = true,
  });
  final CardDataModel cardDetails;
  final bool enableGesture;

  @override
  Widget build(BuildContext context) {
    return CardViewAnimation(
      enableGesture: enableGesture,
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
