import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardNameTextField extends StatelessWidget {
  const CardNameTextField({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
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
        final details = vm.newCard.copyWith(name: value);
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
