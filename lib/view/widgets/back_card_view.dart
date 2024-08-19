import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/view/widgets/card_type_asset.dart';
import 'package:security/view_model/cards_view_model.dart';

class BackCardView extends StatelessWidget with CardTypeDetectorMixin {
  const BackCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cardNo,
      builder: (context, data, _) {
        final card = getCardType(data);
        final color = cardColor(card);
        return ColoredBox(
          color: color,
          child: buildBody(),
        );
      },
    );
  }

  Column buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildBlackBoder(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "CVV/CVC",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 10),
            SizedBox(width: 100, child: buildCardCVV()),
          ],
        ),
        const CardTypeAsset(),
      ],
    );
  }

  Widget buildCardCVV() {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cvv,
      builder: (context, data, _) {
        return TextFormField(
          controller: TextEditingController(text: data),
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "XXX",
          ),
          style: const TextStyle(fontSize: 29),
        );
      },
    );
  }

  Widget buildBlackBoder() {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cardNo,
      builder: (context, data, _) {
        final card = getCardType(data);
        return Container(
          height: 50,
          width: double.infinity,
          color: cardBackStripColor(card),
        );
      },
    );
  }
}
