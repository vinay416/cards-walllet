import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:security/model/card_data_model.dart';

class CardsViewModel with ChangeNotifier {
  CardDataModel newCard = CardDataModel.empty();
  void updateNewCard(CardDataModel details) {
    newCard = details;
    notifyListeners();
  }

  // All cards
  List<CardDataModel> _cards = [];
  List<CardDataModel> get cards => List.unmodifiable(_cards);

  bool addCard(CardDataModel card) {
    final exist = _cards.where((e) => e.cardNo == card.cardNo).isNotEmpty;
    if (exist) {
      log("Card already added");
      return false;
    }
    _cards = [..._cards, card];
    notifyListeners();
    return true;
  }

  bool removeCard(CardDataModel card) {
    _cards.remove(card);
    _cards = [...cards];
    notifyListeners();
    return true;
  }
}
