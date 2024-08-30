import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:security/model/card_data_model.dart';

import '../core/cards_local_storage.dart';

class CardsViewModel with ChangeNotifier {
  CardDataModel editCardDetails = CardDataModel.empty();
  void updateNewCard(CardDataModel details) {
    editCardDetails = details;
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

  void paginateCards(ScrollController controller) {
    controller.addListener(
      () async {
        if (allCardsLoaded) return;
        if (paginating) return;
        final pos = controller.position.pixels;
        final triggerPos = controller.position.maxScrollExtent - 100;
        if (pos < triggerPos) return;
        await _paginateUserCards();
      },
    );
  }

  Future<void> _paginateUserCards() async {
    try {
      _setPaginatingLoading(true);
      await Future.delayed(Durations.long4);
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
    } catch (e) {
      log("Cards pagination error ---> $e");
      _setPaginatingLoading(false);
    }
  }

  Future<(bool success, String? error)> addCard(
    CardDataModel card,
  ) async {
    try {
      final exist = _cards.where((e) => e.id == card.id).isNotEmpty;
      if (exist) {
        log("Card already added ${card.toJson()}");
        return (false, "Card already added");
      }

      final (success, error) = await CardsLocalStorage().saveCard(card);
      if (error != null) throw ErrorDescription(error);
      _cards = [card, ..._cards];
      _totalCards++;
      notifyListeners();
      return (success, null);
    } catch (e) {
      log("Add Card Error ----> $e");
      return (false, e.toString());
    }
  }

  Future<(bool success, String? error)> updateCard(
    CardDataModel card,
  ) async {
    try {
      final notExist = _cards.where((e) => e.id == card.id).isEmpty;
      if (notExist) {
        log("Card not exist ${card.toJson()}");
        return (false, "Card not exist");
      }
      final (success, error) = await CardsLocalStorage().updateCard(card);
      if (error != null) throw ErrorDescription(error);

      final tempCards = [..._cards];
      final index = tempCards.indexWhere((e) => e.id == card.id);
      if (index == -1) throw ErrorDescription("local list index $index");
      tempCards.removeAt(index);
      tempCards.insert(index, card);
      _cards = [...tempCards];
      notifyListeners();
      return (success, null);
    } catch (e) {
      log("Update Card Error ----> $e");
      return (false, e.toString());
    }
  }

  Future<(bool success, String? error)> removeCard(
    CardDataModel card,
  ) async {
    try {
      final exist = _cards.where((e) => e.id == card.id).isNotEmpty;
      if (!exist) {
        throw ErrorDescription("Card not exist");
      }
      final (success, error) = await CardsLocalStorage().removeCard(card);
      if (error != null) throw ErrorDescription(error);

      _cards.remove(card);
      _cards = [...cards];
      _totalCards--;
      notifyListeners();
      return (success, null);
    } catch (e) {
      log("Delete card error ---> $e");
      return (false, e.toString());
    }
  }

  //* Edit mode all cards

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  void setCardsEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final tempCards = [..._cards];
    final item = tempCards.removeAt(oldIndex);
    tempCards.insert(newIndex, item);
    final (success, _) = await CardsLocalStorage().reorderCardKeys(tempCards);
    if (!success) {
      Fluttertoast.showToast(msg: "Reorder Cards failed");
      return;
    }
    _cards = [...tempCards];
    notifyListeners();
  }
}
