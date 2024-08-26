import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardIssuedByTextField extends StatelessWidget {
  const CardIssuedByTextField({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
      onTap: onTap,
      style: const TextStyle(fontSize: 20),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
        LengthLimitingTextInputFormatter(15),
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Issued By - Bank/e-commerce",
        contentPadding: EdgeInsets.all(12),
      ),
      onChanged: (value) {
        final details = vm.newCard.copyWith(issuedBy: value);
        vm.updateNewCard(details);
      },
    );
  }
}
