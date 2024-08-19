import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardTypeAsset extends StatelessWidget with CardTypeDetectorMixin {
  const CardTypeAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cardNo,
      builder: (context, data, _) {
        final card = getCardType(data);
        if (card == null) return const SizedBox.shrink();
        return SizedBox(
          height: 50,
          width: 100,
          child: Image.asset(
            "assets/${card.asset}.png",
          ),
        );
      },
    );
  }
}
