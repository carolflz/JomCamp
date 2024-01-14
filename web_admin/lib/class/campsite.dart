class Campsite {
  final String? id;
  final String address;
  final String category;
  final String level;
  final String name;

  const Campsite({
    this.id,
    required this.address,
    required this.category,
    required this.level,
    required this.name,
  });

  toJson() {
    return {
      "Name": name,
      "Level": level,
      "Category": category,
      "Address": address
    };
  }
}
