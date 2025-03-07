class HomeModel {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  HomeModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.description});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        price: json['price'].toDouble(),
        description: json['description']);
  }
}
