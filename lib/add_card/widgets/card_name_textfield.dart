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
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Name",
      ),
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
