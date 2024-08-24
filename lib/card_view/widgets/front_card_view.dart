import 'package:flutter/material.dart';

import 'package:security/card_view/widgets/card_type_asset.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/model/card_data_model.dart';

class FrontCardView extends StatelessWidget with CardTypeDetectorMixin {
  const FrontCardView({super.key, required this.cardDetails});
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    final card = getCardType(cardDetails.cardNo);
    final color = cardColor(card);
    return Container(
      color: color,
      padding: const EdgeInsets.all(20.0),
      child: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCardChip(),
            buildTapAsset(),
          ],
        ),
        const SizedBox(height: 10),
        buildCardNo(),
        buildCardExpiry(),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: buildCardName()),
            const SizedBox(width: 20),
            CardTypeAsset(cardDetails: cardDetails),
          ],
        ),
      ],
    );
  }

  Widget buildCardNo() {
    final card = getCardType(cardDetails.cardNo);
    return TextFormField(
      controller: TextEditingController(text: cardDetails.cardNo),
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "XXXX XXXX XXXX XXXX",
        hintStyle: TextStyle(color: cardTextColor(card)),
        isCollapsed: true,
      ),
      style: TextStyle(
        fontSize: 29,
        color: cardTextColor(card),
      ),
    );
  }

  Widget buildCardExpiry() {
    final card = getCardType(cardDetails.cardNo);
    return TextFormField(
      controller: TextEditingController(text: cardDetails.expiry),
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "XX/XXXX",
        isCollapsed: true,
        hintStyle: TextStyle(color: cardTextColor(card)),
      ),
      style: TextStyle(
        fontSize: 20,
        color: cardTextColor(card),
      ),
    );
  }

  Widget buildCardName() {
    final card = getCardType(cardDetails.cardNo);
    final name = cardDetails.name.toUpperCase();
    return TextFormField(
      controller: TextEditingController(text: name),
      readOnly: true,
      maxLines: 2,
      minLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "XXXXXX XXXXXX",
        isCollapsed: true,
        hintStyle: TextStyle(color: cardTextColor(card)),
      ),
      style: TextStyle(
        fontSize: 20,
        color: cardTextColor(card),
      ),
    );
  }

  Widget buildCardChip() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.black,
        height: 49,
        width: 55,
        child: Image.asset(
          "assets/card-chip.png",
        ),
      ),
    );
  }

  Widget buildTapAsset() {
    return SizedBox(
      height: 30,
      width: 30,
      child: Image.asset(
        "assets/contactless-payment.png",
      ),
    );
  }
}
