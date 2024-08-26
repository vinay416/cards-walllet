import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardNameTextField extends StatelessWidget {
  const CardNameTextField({super.key, required this.onTap, required this.cardDetails,});
  final VoidCallback onTap;
  final CardDataModel cardDetails;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
      initialValue: cardDetails.name,
      onTap: onTap,
      style: const TextStyle(fontSize: 20),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Name",
        contentPadding: EdgeInsets.all(12),
      ),
      scrollPadding: const EdgeInsets.only(bottom: 220),
      onChanged: (value) {
        final details = cardDetails.copyWith(name: value);
        vm.updateNewCard(details);
      },
      validator: (value) {
        if (value == null) return null;
        if (value.isEmpty) return "Name required";
        return null;
      },
    );
  }
}
