import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardCVVTextField extends StatelessWidget {
  const CardCVVTextField({
    super.key,
    required this.onTap,
    required this.cardDetails,
  });
  final VoidCallback onTap;
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
      initialValue: cardDetails.cvv,
      onTap: onTap,
      style: const TextStyle(fontSize: 20),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "CVV",
        contentPadding: EdgeInsets.all(12),
      ),
      onChanged: (value) {
        final details = cardDetails.copyWith(cvv: value);
        vm.updateNewCard(details);
      },
      scrollPadding: const EdgeInsets.only(bottom: 220),
      validator: (value) {
        if (value == null) return "";
        if (value.isEmpty) return "Required";
        final bool isValid = value.length == 3;
        if (!isValid) {
          return "CVV not valid";
        }
        return null;
      },
    );
  }
}
