import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardCVVTextField extends StatelessWidget {
  const CardCVVTextField({super.key, required this.onTap});
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
      onTap: onTap,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "CVV",
      ),
      onChanged: (value) {
        final details = vm.newCard.copyWith(cvv: value);
        vm.updateNewCard(details);
      },
      validator: (value) {
        if (value == null) return "";
        final bool isValid = value.length == 3;
        if (!isValid) {
          return "CVV not valid";
        }
        return null;
      },
    );
  }
}
