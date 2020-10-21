class NoteForListing {
  String id;
  String name;
  dynamic degree;
  String review;
  dynamic amount;
  String spirit;

  NoteForListing(
      {this.id, this.name, this.degree, this.review, this.amount, this.spirit});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      id: item['id'],
      name: item['name'],
      degree: item['degree'],
      review: item['review'],
      amount: item['amount'],
      spirit: item['spirit'],
    );
  }
}
