import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:security/model/card_data_model.dart';

const _userCardsKey = "USER_CARDS";

class CardsLocalStorage {
  CardsLocalStorage._();
  static final _instance = CardsLocalStorage._();
  factory CardsLocalStorage() => _instance;

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions.defaultOptions,
  );

  Map<String, dynamic> _cardKeys = {};

  Future<(bool success, String? error)> loadCardKeys() async {
    try {
      final cardsKeys = await _storage.read(key: _userCardsKey);
      if (cardsKeys == null) throw ErrorDescription("Cards Keys null");
      final mapKeys = Map<String, dynamic>.from(jsonDecode(cardsKeys));
      _cardKeys = mapKeys;
      return (true, null);
    } catch (e) {
      log("Card Keys ---> $e");
      return (false, e.toString());
    }
  }

  Future<(List<CardDataModel>, int)> retriveCards({
    int start = 1,
  }) async {
    const int offset = 10;
    final int totalCards = _cardKeys.length;
    List<CardDataModel> cardsList = [];
    try {
      final startOffset = (start - 1);
      final int remainCards = totalCards - startOffset;
      final bool isMore = remainCards > offset;
      final int end = (isMore ? offset : remainCards) + startOffset;
      for (int i = startOffset; i < end; i++) {
        final cardNo = _cardKeys.values.elementAt(i);
        final data = await _storage.read(key: cardNo);
        if (data == null) {
          log("Card No $cardNo data error");
          continue;
        }
        final CardDataModel card = CardDataModel.fromJson(data);
        cardsList.add(card);
      }
      return (cardsList, totalCards);
    } catch (e) {
      log("Cards fetcting failed start:$start error --> $e");
      return (cardsList, totalCards);
    }
  }

  Future<(bool success, String? error)> saveCard(CardDataModel card) async {
    try {
      final cardNoKey = card.cardNo;
      final cardData = card.toJson();
      // Add key set if not exist
      if (!_cardKeyExist(cardNoKey)) {
        _cardKeys.addAll({cardNoKey: cardNoKey});
        await _storage.write(key: _userCardsKey, value: jsonEncode(_cardKeys));
      }
      await _storage.write(key: cardNoKey, value: cardData);
      return (true, null);
    } catch (e) {
      log("Saving failed error --> $e");
      return (false, "Saving failed");
    }
  }

   Future<(bool success, String? error)> updateCard(CardDataModel card) async {
    try {
      final cardNoKey = card.cardNo;
      final cardData = card.toJson();
      // if not exist
      if (!_cardKeyExist(cardNoKey)) {
        throw ErrorDescription("Card Key not exist $cardNoKey");
      }
      await _storage.write(key: cardNoKey, value: cardData);
      return (true, null);
    } catch (e) {
      log("Updating failed error --> $e");
      return (false, "Updating failed");
    }
  }

  Future<(bool success, String? error)> removeCard(CardDataModel card) async {
    try {
      final cardNoKey = card.cardNo;
      // Add key set if not exist
      if (!_cardKeyExist(cardNoKey)) {
        throw ErrorDescription("Card Key missing");
      }

      await _storage.delete(key: cardNoKey);
      // checking if actually deleted
      if (await _storage.containsKey(key: cardNoKey)) {
        throw ErrorDescription("Card info delete failed");
      }
      _cardKeys.remove(cardNoKey);
      await _storage.write(key: _userCardsKey, value: jsonEncode(_cardKeys));

      return (true, null);
    } catch (e) {
      log("Delete failed error --> $e");
      return (false, "Deleting failed");
    }
  }

  bool _cardKeyExist(String cardNo) {
    return _cardKeys.containsKey(cardNo);
  }
}
