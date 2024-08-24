import 'package:flutter/material.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/card_view/widgets/card_type_asset.dart';
import 'package:security/model/card_data_model.dart';

class BackCardView extends StatelessWidget with CardTypeDetectorMixin {
  const BackCardView({super.key, required this.cardDetails});
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    final card = getCardType(cardDetails.cardNo);
    final color = cardColor(card);
    return ColoredBox(
      color: color,
      child: buildBody(card),
    );
  }

  Column buildBody(CardType? card) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: cardBackStripColor(card),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CVV/CVC",
              style: TextStyle(
                fontSize: 20,
                color: cardTextColor(card),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(width: 100, child: buildCardCVV()),
          ],
        ),
        CardTypeAsset(cardDetails: cardDetails),
      ],
    );
  }

  Widget buildCardCVV() {
    final card = getCardType(cardDetails.cardNo);
    return TextFormField(
      controller: TextEditingController(text: cardDetails.cvv),
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "XXX",
        hintStyle: TextStyle(color: cardTextColor(card)),
      ),
      style: TextStyle(
        fontSize: 29,
        color: cardTextColor(card),
      ),
    );
  }
}
