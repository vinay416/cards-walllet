import 'package:flutter/material.dart';
import 'package:security/add_card/widgets/card_cvv_textfield.dart';
import 'package:security/add_card/widgets/card_expiry_textfield.dart';
import 'package:security/add_card/widgets/card_issued_by_textfield.dart';
import 'package:security/add_card/widgets/card_name_textfield.dart';
import 'package:security/add_card/widgets/card_no_textfield.dart';
import 'package:security/model/card_data_model.dart';

class CardsFormFields extends StatelessWidget {
  const CardsFormFields({
    super.key,
    required this.showFront,
    required this.showBack,
    required this.cardDetails,
  });
  final VoidCallback showFront;
  final VoidCallback showBack;
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CardIssuedByTextField(
                onTap: showFront,
                cardDetails: cardDetails,
              ),
              const SizedBox(height: 20),
              build1stRow(),
              const SizedBox(height: 20),
              build2ndRow(),
              const SizedBox(height: 20),
              buildButtonSpace(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget build1stRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: CardNoTextField(
            onTap: showFront,
            cardDetails: cardDetails,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: CardExpiryTextField(
            onTap: showFront,
            cardDetails: cardDetails,
          ),
        ),
      ],
    );
  }

  Widget build2ndRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: CardNameTextField(
            onTap: showFront,
            cardDetails: cardDetails,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CardCVVTextField(
            onTap: showBack,
            cardDetails: cardDetails,
          ),
        ),
      ],
    );
  }

  Widget buildButtonSpace(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: (bottom != 0) ? 400 : 0,
    );
  }
}
