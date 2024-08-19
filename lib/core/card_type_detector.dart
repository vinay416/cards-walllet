// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum CardType {
  AmericanExpress("American Express"),
  MasterCard("Master Card"),
  Rupay("Rupay"),
  Discover("Discover"),
  Visa("Visa");

  final String rawValue;
  String? get asset {
    return rawValue.replaceAll(" ", "-").toLowerCase();
  }

  const CardType(this.rawValue);
}

mixin CardTypeDetectorMixin {
// '*CARD TYPES            *PREFIX           *WIDTH
// 'American Express       34, 37            15
// 'Diners Club            300 to 305, 36    14
// 'Carte Blanche          38                14
// 'Discover               6011              16
// 'EnRoute                2014, 2149        15
// 'JCB                    3                 16
// 'JCB                    2131, 1800        15
// 'Master Card            51 to 55          16
// 'Visa                   4                 13, 16
// 'Rupay                  60,6521,6522      16

  CardType? getCardType(String cardNo) {
    if (cardNo.length >= 4) {
      switch (int.parse(cardNo.substring(0, 4))) {
        case 6011:
          return CardType.Discover;
        case 6521:
        case 6522:
          return CardType.Rupay;
        default:
      }
    }

    if (cardNo.length >= 2) {
      switch (int.parse(cardNo.substring(0, 2))) {
        case 34:
        case 37:
          return CardType.AmericanExpress;
        case 51:
        case 52:
        case 53:
        case 54:
        case 55:
          return CardType.MasterCard;
        case 60:
          return CardType.Rupay;
        default:
      }
    }

    if (cardNo.isNotEmpty) {
      switch (int.parse(cardNo[0])) {
        case 4:
          return CardType.Visa;
        default:
      }
    }

    return null;
  }

  Color cardColor(CardType? type) {
    Color color = Colors.white70;
    switch (type) {
      case CardType.AmericanExpress:
        color = Colors.black;
        break;
      case CardType.Discover:
      case CardType.MasterCard:
        color = Colors.blue;
        break;
      case CardType.Rupay:
        color = Colors.amber;
        break;
      case CardType.Visa:
        color = Colors.blueAccent.shade700;
        break;
      default:
    }
    return color;
  }

  Color cardBackStripColor(CardType? type) {
    Color color = Colors.black;
    switch (type) {
      case CardType.AmericanExpress:
        color = Colors.white70;
        break;
      default:
    }
    return color;
  }
}
