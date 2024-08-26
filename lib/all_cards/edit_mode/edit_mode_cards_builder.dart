import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:security/add_card/add_card_view.dart';
import 'package:security/all_cards/all_cards_builder.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/overlay/overlay_loader_mixin.dart';
import 'package:security/view_model/cards_view_model.dart';

// ignore: must_be_immutable
class EditModeCardsBuilder extends StatelessWidget with OverlayLoaderMixin {
  EditModeCardsBuilder({super.key, required this.cards});
  final List<CardDataModel> cards;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        final card = cards[index];
        return SlidableCardItem(
          key: ValueKey(card.cardNo),
          card: card,
          index: index,
          onDelete: () async {
            showFullLoader(context);
            await vm.removeCard(card);
            hideFullLoader();
          },
          onEdit: () {
            AddCard.showDialog(context, cardDetails: card);
          },
        );
      },
      itemCount: cards.length,
      onReorder: vm.onReorder,
    );
  }
}

class SlidableCardItem extends StatelessWidget {
  const SlidableCardItem({
    super.key,
    required this.card,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });
  final CardDataModel card;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: onDelete),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) => onEdit(),
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableDragStartListener(
          index: index,
          child: IgnorePointer(
            ignoring: true,
            child: CardBuilderItem(
              enableGesture: false,
              cardDetails: card,
            ),
          ),
        ),
      ),
    );
  }
}
