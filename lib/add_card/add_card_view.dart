import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:security/add_card/widgets/card_validate_button.dart';
import 'package:security/add_card/widgets/cards_form_fields.dart';
import 'package:security/card_view/card_view_animation.dart';
import 'package:security/model/card_data_model.dart';
import 'package:security/add_card/widgets/card_view.dart';
import 'package:security/overlay/overlay_loader_mixin.dart';
import 'package:security/view_model/cards_view_model.dart';

class AddCard {
  static void showDialog(
    BuildContext context, {
    CardDataModel? cardDetails,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: borderShape),
      context: context,
      builder: (context) => AddCardView(cardDetails: cardDetails),
    );
  }

  static get borderShape => const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      );
}

class AddCardView extends StatefulWidget {
  const AddCardView({super.key, this.cardDetails});
  final CardDataModel? cardDetails;

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
    vm.editCardDetails = widget.cardDetails ?? CardDataModel.empty();
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
        heightFactor: 0.92,
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
          buildPreviewCard(),
          const SizedBox(height: 20),
          buildFormFields(),
          const Spacer(),
          CardValidateButton(onTap: onTap),
        ],
      ),
    );
  }

  Widget buildFormFields() {
    return Selector<CardsViewModel, CardDataModel>(
      selector: (p0, p1) => p1.editCardDetails,
      builder: (context, cardDetails, child) {
        return CardsFormFields(
          cardDetails: vm.editCardDetails,
          showBack: showBack,
          showFront: showFront,
        );
      },
    );
  }

  Widget buildPreviewCard() {
    return Selector<CardsViewModel, CardDataModel>(
      selector: (p0, p1) => p1.editCardDetails,
      builder: (context, data, _) {
        return CardView(
          cardController: cardController,
          data: data,
        );
      },
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
    final bool isAddingCard = widget.cardDetails == null;
    final success = isAddingCard ? await addCard() : await updateCard();
    hideFullLoader();
    if (!success) return;
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<bool> addCard() async {
    final (success, _) = await vm.addCard(vm.editCardDetails);
    await Future.delayed(Durations.long2);
    Fluttertoast.showToast(
      msg: success ? "Card saved" : "Card save failed",
    );
    return success;
  }

  Future<bool> updateCard() async {
    final (success, _) = await vm.updateCard(vm.editCardDetails);
    await Future.delayed(Durations.long2);
    Fluttertoast.showToast(
      msg: success ? "Card updated" : "Card updation failed",
    );
    return success;
  }
}
