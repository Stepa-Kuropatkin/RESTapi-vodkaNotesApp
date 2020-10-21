import 'package:flutter/foundation.dart';

class Note {
  String id;
  String name;
  dynamic degree;
  String review;
  dynamic amount;
  String spirit;

  Note({
    @required this.id,
    @required this.name,
    @required this.degree,
    @required this.review,
    @required this.amount,
    @required this.spirit,
  });

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      id: item['id'],
      name: item['name'],
      degree: item['degree'],
      review: item['review'],
      amount: item['amount'],
      spirit: item['spirit'],
    );
  }
}
