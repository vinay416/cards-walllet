// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardDataModel {
  final String cardNo;
  final String expiry;
  final String name;
  final String cvv;
  const CardDataModel({
    required this.cardNo,
    required this.expiry,
    required this.name,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNo': cardNo,
      'expiry': expiry,
      'name': name,
      'cvv': cvv,
    };
  }

  factory CardDataModel.fromMap(Map<String, dynamic> map) {
    return CardDataModel(
      cardNo: map['cardNo'] as String,
      expiry: map['expiry'] as String,
      name: map['name'] as String,
      cvv: map['cvv'] as String,
    );
  }

  factory CardDataModel.empty() {
    return const CardDataModel(
      cardNo: "",
      expiry: "",
      name: "",
      cvv: "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CardDataModel.fromJson(String source) {
    return CardDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  CardDataModel copyWith({
    String? cardNo,
    String? expiry,
    String? name,
    String? cvv,
  }) {
    return CardDataModel(
      cardNo: cardNo ?? this.cardNo,
      expiry: expiry ?? this.expiry,
      name: name ?? this.name,
      cvv: cvv ?? this.cvv,
    );
  }
}
