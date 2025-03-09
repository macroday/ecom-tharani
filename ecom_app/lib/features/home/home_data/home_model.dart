class HomeModel {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final Rating rating;
  HomeModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.description,
      required this.rating});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        price: json['price'].toDouble(),
        description: json['description'],
        rating: Rating.fromJson(json['rating']));
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }
}
