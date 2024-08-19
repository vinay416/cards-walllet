import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/add_card/card_view.dart';
import 'package:security/view_model/cards_view_model.dart';

import 'widgets/card_cvv_textfield.dart';
import 'widgets/card_expiry_textfield.dart';
import 'widgets/card_name_textfield.dart';
import 'widgets/card_no_textfield.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
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
    final topbar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - topbar,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: buildForm(),
        ),
      ),
    );
  }

  Widget buildForm() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            CardView(cardController: cardController),
            const SizedBox(height: 50),
            CardNoTextField(onTap: showFront),
            const SizedBox(height: 20),
            CardNameTextField(onTap: showFront),
            const SizedBox(height: 20),
            buildLastRow(),
            const Spacer(),
            buildValidateButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildLastRow() {
    return Row(
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
        onPressed: () {
          final isValid = formKey.currentState?.validate() ?? false;
          if (!isValid) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: "Invaild detials");
            return;
          }
          vm.addCard(vm.newCard);
        },
        child: const Text(
          "Validate",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
