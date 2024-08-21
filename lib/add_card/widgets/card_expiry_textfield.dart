import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:security/view_model/cards_view_model.dart';

class CardExpiryTextField extends StatefulWidget {
  const CardExpiryTextField({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<CardExpiryTextField> createState() => _CardExpiryTextFieldState();
}

class _CardExpiryTextFieldState extends State<CardExpiryTextField> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CardsViewModel>();

    return TextFormField(
      onTap: widget.onTap,
      inputFormatters: [
        maskFormatter,
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Expiry",
      ),
      scrollPadding: const EdgeInsets.only(bottom: 220),
      onChanged: (value) {
        final details = vm.newCard.copyWith(expiry: value);
        vm.updateNewCard(details);
      },
      validator: (value) {
        if (value == null) return "";
        final slashIndex = value.indexOf('/');
        final dateStr = value.substring(0, slashIndex);
        final yearStr = value.substring(slashIndex, value.length - 1);
        final bool isValid = isDateValid(dateStr) && isYearValid(yearStr);
        if (!isValid) {
          return "Expiry not valid";
        }
        return null;
      },
    );
  }

  bool isDateValid(String dateStr) {
    int? date = int.tryParse(dateStr);
    if (date == null) return false;
    if (date >= 1 || date <= 31) return true;
    return false;
  }

  bool isYearValid(String yearStr) {
    int? year = int.tryParse(yearStr);
    if (year == null) return false;
    final currentYear = DateTime.now().year;
    if (year < currentYear || year > (currentYear + 5)) return false;
    return true;
  }
}
