import 'package:flutter/widgets.dart';
import 'package:security/core/card_type_detector.dart';
import 'package:security/model/card_data_model.dart';

class CardTypeAsset extends StatelessWidget with CardTypeDetectorMixin {
  const CardTypeAsset({super.key, required this.cardDetails});
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    final card = getCardType(cardDetails.cardNo);
    if (card == null) return const SizedBox.shrink();
    return SizedBox(
      height: 50,
      width: 100,
      child: Image.asset(
        "assets/${card.asset}.png",
      ),
    );
  }
}
