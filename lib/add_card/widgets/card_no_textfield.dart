import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardNoTextField extends StatefulWidget {
  const CardNoTextField({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<CardNoTextField> createState() => _CardNoTextFieldState();
}

class _CardNoTextFieldState extends State<CardNoTextField> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();
    return TextFormField(
      onTap: widget.onTap,
      style: const TextStyle(fontSize: 20),
      inputFormatters: [
        maskFormatter,
      ],
      onChanged: (value) {
        final details = vm.newCard.copyWith(cardNo: value);
        vm.updateNewCard(details);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Card Number",
        contentPadding: EdgeInsets.all(12),
      ),
      validator: (value) {
        if (value == null) return null;
        if (value.isEmpty) return "Required";
        final unmaskVal = maskFormatter.getUnmaskedText();
        final bool isValid = unmaskVal.length == 16;
        if (!isValid) return "Card no. required";
        return null;
      },
    );
  }
}
