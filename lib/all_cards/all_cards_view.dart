import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/add_card/add_card_view.dart';
import 'package:security/all_cards/widgets/empty_all_cards.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

class AllCardsView extends StatelessWidget {
  const AllCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Cards Wallet",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: buildCards(),
      floatingActionButton: buildFAB(context),
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      shape: const StadiumBorder(),
      onPressed: () {
        AddCard.newCard(context);
      },
      label: const Text(
        "Add",
        style: TextStyle(fontSize: 18),
      ),
      icon: const Icon(Icons.add),
    );
  }

  Widget buildCards() {
    return Selector<CardsViewModel, List<CardDataModel>>(
      builder: (context, value, child) {
        return const EmptyAllCards();
      },
      selector: (p0, p1) => p1.cards,
    );
  }
}
