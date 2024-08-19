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
            const CardTypeAsset(),
          ],
        ),
      ],
    );
  }

  Widget buildCardNo() {
    return TextFormField(
      controller: TextEditingController(text: cardDetails.cardNo),
      readOnly: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "XXXX XXXX XXXX XXXX",
        isCollapsed: true,
      ),
      style: const TextStyle(fontSize: 29),
    );
  }

  Widget buildCardExpiry() {
    return TextFormField(
      controller: TextEditingController(text: cardDetails.expiry),
      readOnly: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "XX/XXXX",
        isCollapsed: true,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget buildCardName() {
    return TextFormField(
      controller: TextEditingController(text: cardDetails.name),
      readOnly: true,
      maxLines: 2,
      minLines: 1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "XXXXXX XXXXXX",
        isCollapsed: true,
      ),
      style: const TextStyle(fontSize: 20),
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
