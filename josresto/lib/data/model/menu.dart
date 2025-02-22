class Menus {
  final List<MenuItem> food;
  final List<MenuItem> drinks;

  Menus({List<MenuItem>? food, List<MenuItem>? drinks})
      : food = food ?? [],
        drinks = drinks ?? [];

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        food: (json["foods"] as List<dynamic>? ?? [])
            .map((item) => MenuItem.fromJson(item))
            .toList(),
        drinks: (json["drinks"] as List<dynamic>? ?? [])
            .map((item) => MenuItem.fromJson(item))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        "foods": food.map((f) => f.toJson()).toList(),
        "drinks": drinks.map((d) => d.toJson()).toList(),
      };
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      MenuItem(name: json["name"] as String? ?? "");

  Map<String, dynamic> toJson() => {"name": name};
}
