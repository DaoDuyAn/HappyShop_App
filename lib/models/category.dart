import 'dart:convert';

Category categoryModelFromJson(String str) =>
    Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  final String id;
  final String title;
  final String image;

  Category({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    image: json["image"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
  };
}

// final List<Category> categories = [
//   Category(id: "1", title: "Shoes", image: "assets/images/shoes.jpg"),
//   Category(id: "2", title: "Beauty", image: "assets/images/beauty.png"),
//   Category(id: "3", title: "PC", image: "assets/images/pc.jpg"),
//   Category(id: "4", title: "Mobile", image: "assets/images/mobile.jpg"),
//   Category(id: "5", title: "Watch", image: "assets/images/watch.png"),
//   Category(id: "6", title: "Shoes", image: "assets/images/shoes.jpg"),
//   Category(id: "7", title: "Beauty", image: "assets/images/beauty.png"),
//   Category(id: "8", title: "PC", image: "assets/images/pc.jpg"),
// ];
