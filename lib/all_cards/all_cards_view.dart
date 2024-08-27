import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/add_card/add_card_view.dart';
import 'package:security/all_cards/all_cards_builder.dart';
import 'package:security/all_cards/pagination/cards_pagination_loader.dart';
import 'package:security/all_cards/widgets/empty_all_cards.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

import 'widgets/shimmer_all_cards.dart';

class AllCardsView extends StatefulWidget {
  const AllCardsView({super.key});

  @override
  State<AllCardsView> createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  late CardsViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<CardsViewModel>();
    vm.fetchUserCards();
  }

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
        actions: [
          buildAppbarAction(),
          const SizedBox(width: 10),
        ],
      ),
      body: buildCards(),
      floatingActionButton: buildFAB(context),
    );
  }

  Widget buildAppbarAction() {
    return Selector<CardsViewModel, bool>(
      builder: (context, isEditMode, child) {
        return TextButton(
          onPressed: vm.setCardsEditMode,
          child: isEditMode
              ? const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                )
              : const Icon(Icons.edit_square, color: Colors.blue),
        );
      },
      selector: (p0, p1) => p1.isEditMode,
    );
  }

  Widget buildFAB(BuildContext context) {
    return Selector<CardsViewModel, bool>(
      builder: (context, loading, child) {
        if (loading) return const SizedBox.shrink();

        return FloatingActionButton.extended(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.blue[600]!,
              width: 2.5,
            ),
          ),
          onPressed: () => AddCard.showDialog(context),
          label: const Text(
            "Add",
            style: TextStyle(fontSize: 18),
          ),
          icon: const Icon(Icons.add),
        );
      },
      selector: (p0, p1) => p1.initialLoading,
    );
  }

  Widget buildCards() {
    return Selector<CardsViewModel, (List<CardDataModel>, bool)>(
      builder: (context, values, child) {
        final cards = values.$1;
        final initialLoading = values.$2;
        if (initialLoading) return const ShimmerAllCards();
        if (cards.isEmpty) return const EmptyAllCards();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AllCardsBuilder(cards: cards),
            ),
            const SliverToBoxAdapter(
              child: CardsPaginationLoader(),
            ),
          ],
        );
      },
      selector: (p0, p1) => (p1.cards, p1.initialLoading),
    );
  }
}
