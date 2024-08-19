import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/card_view/widgets/card_type_asset.dart';
import 'package:security/view_model/cards_view_model.dart';

class FrontCardView extends StatelessWidget with CardTypeDetectorMixin {
  const FrontCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cardNo,
      builder: (context, data, _) {
        final card = getCardType(data);
        final color = cardColor(card);
        return Container(
          color: color,
          padding: const EdgeInsets.all(20.0),
          child: buildBody(),
        );
      },
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
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.cardNo,
      builder: (context, data, _) {
        return TextFormField(
          controller: TextEditingController(text: data),
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "XXXX XXXX XXXX XXXX",
            isCollapsed: true,
          ),
          style: const TextStyle(fontSize: 29),
        );
      },
    );
  }

  Widget buildCardExpiry() {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.expiry,
      builder: (context, data, _) {
        return TextFormField(
          controller: TextEditingController(text: data),
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "XX/XXXX",
            isCollapsed: true,
          ),
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }

  Widget buildCardName() {
    return Selector<CardsViewModel, String>(
      selector: (p0, p1) => p1.newCard.name,
      builder: (context, data, _) {
        return TextFormField(
          controller: TextEditingController(text: data),
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
      },
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
