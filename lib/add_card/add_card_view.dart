import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/card_view/card_view.dart';
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
  late CardsViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<CardsViewModel>();
    vm.newCard = CardDataModel.empty();
  }

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
            const CardView(),
            const SizedBox(height: 50),
            const CardNoTextField(),
            const SizedBox(height: 20),
            const CardNameTextField(),
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
    return const Row(
      children: [
        Expanded(
          child: CardExpiryTextField(),
        ),
        SizedBox(width: 20),
        Expanded(
          child: CardCVVTextField(),
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
