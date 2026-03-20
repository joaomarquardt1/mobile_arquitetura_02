
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      rating: ((json['rating'] as Map<String, dynamic>?)?['rate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
