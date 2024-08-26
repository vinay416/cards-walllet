import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:security/model/card_data_model.dart';

import '../core/cards_local_storage.dart';

class CardsViewModel with ChangeNotifier {
  CardDataModel newCard = CardDataModel.empty();
  void updateNewCard(CardDataModel details) {
    newCard = details;
    notifyListeners();
  }

  // All cards
  List<CardDataModel> _cards = [];
  int _totalCards = 0;
  List<CardDataModel> get cards => List.unmodifiable(_cards);

  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;

  void _setInitialLoading(bool status) {
    _initialLoading = status;
    notifyListeners();
  }

  Future<bool> fetchUserCards() async {
    try {
      _initialLoading = true;
      _cards.clear();
      final (list, totalCount) = await CardsLocalStorage().retriveCards();
      if (totalCount != 0 && list.isEmpty) {
        throw ErrorDescription("list:$list, totalCount:$totalCount");
      }

      _cards = [...list];
      _totalCards = totalCount;
      _setInitialLoading(false);
      return true;
    } catch (e) {
      log("Cards fetch ---> $e");
      _setInitialLoading(false);
      return false;
    }
  }

  bool _paginating = false;
  bool get paginating => _paginating;

  void _setPaginatingLoading(bool status) {
    _paginating = status;
    notifyListeners();
  }

  bool get allCardsLoaded => _cards.length == _totalCards;

  Future<bool> paginateUserCards() async {
    try {
      _setPaginatingLoading(true);
      final start = _cards.length + 1;
      final (list, totalCount) = await CardsLocalStorage().retriveCards(
        start: start,
      );

      if ((totalCount - start) != 0 && list.isEmpty) {
        throw ErrorDescription("list:$list, totalCount:$totalCount");
      }

      _cards = [..._cards, ...list];
      _totalCards = totalCount;
      _setPaginatingLoading(false);
      return true;
    } catch (e) {
      log("Cards pagination error ---> $e");
      _setPaginatingLoading(false);
      return false;
    }
  }

  bool _fullLoader = false;
  bool get fullLoader => _fullLoader;

  void _setFullLoader(bool status) {
    _fullLoader = status;
    notifyListeners();
  }

  Future<(bool success, String? error)> addCard(
    CardDataModel card,
  ) async {
    try {
      final exist = _cards.where((e) => e.cardNo == card.cardNo).isNotEmpty;
      if (exist) {
        log("Card already added ${card.toJson()}");
        return (false, "Card already added");
      }
      _setFullLoader(true);
      final (success, error) = await CardsLocalStorage().saveCard(card);
      if (error != null) throw ErrorDescription(error);

      _cards = [..._cards, card];
      _totalCards++;
      _setFullLoader(false);
      return (success, null);
    } catch (e) {
      log("Add Card Error ----> $e");
      _setFullLoader(false);
      return (false, e.toString());
    }
  }

  Future<(bool success, String? error)> removeCard(
    CardDataModel card,
  ) async {
    try {
      final exist = _cards.where((e) => e.cardNo == card.cardNo).isNotEmpty;
      if (!exist) {
        throw ErrorDescription("Card not exist");
      }
      _setFullLoader(true);
      final (success, error) = await CardsLocalStorage().removeCard(card);
      if (error != null) throw ErrorDescription(error);

      _cards.remove(card);
      _cards = [...cards];
      _totalCards--;
      _setFullLoader(false);
      return (success, null);
    } catch (e) {
      log("Delete card error ---> $e");
      _setFullLoader(false);
      return (false, e.toString());
    }
  }

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  void setCardsEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }
}
