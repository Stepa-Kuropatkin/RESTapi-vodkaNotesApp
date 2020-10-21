import 'package:flutter/foundation.dart';

class NoteInsert {
  String id;
  String name;
  String degree;
  String review;
  String amount;
  String spirit;

  NoteInsert({
    @required this.id,
    @required this.name,
    @required this.degree,
    @required this.review,
    @required this.amount,
    @required this.spirit,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "degree": degree,
      "review": review,
      "amount": amount,
      "spirit": spirit,
    };
  }
}
