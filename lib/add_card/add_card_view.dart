import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/add_card/card_view.dart';
import 'package:security/overlay/overlay_loader_mixin.dart';
import 'package:security/view_model/cards_view_model.dart';

import 'widgets/card_cvv_textfield.dart';
import 'widgets/card_expiry_textfield.dart';
import 'widgets/card_name_textfield.dart';
import 'widgets/card_no_textfield.dart';

class AddCard {
  static void newCard(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => const AddCardView(),
    );
  }
}

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> with OverlayLoaderMixin {
  final formKey = GlobalKey<FormState>();
  final CardController cardController = CardController();
  late CardsViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<CardsViewModel>();
    vm.newCard = CardDataModel.empty();
  }

  void showFront() => cardController.reverse();
  void showBack() => cardController.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        showFront();
      },
      child: FractionallySizedBox(
        heightFactor: 0.90,
        child: Padding(
          padding: const EdgeInsets.all(10).copyWith(top: 20),
          child: buildForm(),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CardView(cardController: cardController),
          const SizedBox(height: 20),
          buildFields(),
          const Spacer(),
          buildValidateButton(),
        ],
      ),
    );
  }

  Widget buildFields() {
    return Expanded(
      flex: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CardNoTextField(onTap: showFront),
              const SizedBox(height: 20),
              CardNameTextField(onTap: showFront),
              const SizedBox(height: 20),
              buildLastRow(),
              buildButtonSpace(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonSpace() {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: (bottom != 0) ? 400 : 0,
    );
  }

  Widget buildLastRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CardExpiryTextField(onTap: showFront),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CardCVVTextField(onTap: showBack),
        ),
      ],
    );
  }

  Widget buildValidateButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.black),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
        onPressed: onTap,
        child: const Text(
          "Validate",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  void onTap() async {
    showFront();
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Invaild detials");
      return;
    }
    showFullLoader(context);
    final (success, _) = await vm.addCard(vm.newCard);
    Fluttertoast.showToast(
      msg: success ? "Card saved" : "Card save failed",
    );
    hideFullLoader();
    if (!success) return;
    Navigator.pop(context);
  }
}
