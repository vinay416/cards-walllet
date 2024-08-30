// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardDataModel {
  final String id;
  final String cardNo;
  final String expiry;
  final String name;
  final String cvv;
  final String? issuedBy;
  const CardDataModel({
    required this.id,
    required this.cardNo,
    required this.expiry,
    required this.name,
    required this.cvv,
    this.issuedBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNo': cardNo,
      'expiry': expiry,
      'name': name,
      'cvv': cvv,
      'issuedBy': issuedBy ?? "",
    };
  }

  factory CardDataModel.fromMap(Map<String, dynamic> map) {
    return CardDataModel(
      id: map['id'] as String,
      cardNo: map['cardNo'] as String,
      expiry: map['expiry'] as String,
      name: map['name'] as String,
      cvv: map['cvv'] as String,
      issuedBy: map["issuedBy"] ?? "",
    );
  }

  factory CardDataModel.empty() {
    return const CardDataModel(
      cardNo: "",
      expiry: "",
      name: "",
      cvv: "",
      issuedBy: "",
      id: "",
    );
  }

  factory CardDataModel.createNew() {
    return CardDataModel(
      cardNo: "",
      expiry: "",
      name: "",
      cvv: "",
      issuedBy: "",
      id: DateTime.now().millisecond.toString(),
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
    String? issuedBy,
  }) {
    return CardDataModel(
        id: id,
        cardNo: cardNo ?? this.cardNo,
        expiry: expiry ?? this.expiry,
        name: name ?? this.name,
        cvv: cvv ?? this.cvv,
        issuedBy: issuedBy ?? this.issuedBy ?? "");
  }
}
