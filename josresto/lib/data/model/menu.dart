class Menus {
  final List<MenuItem> food;
  final List<MenuItem> drinks;

  Menus({required this.food, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      food: (json["foods"] as List<dynamic>?)
              ?.map((item) => MenuItem.fromJson(item))
              .toList() ??
          [],
      drinks: (json["drinks"] as List<dynamic>?)
              ?.map((item) => MenuItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json["name"] ?? "",
    );
  }
}
