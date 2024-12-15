import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final double price;
  final String title;
  final String thumbnail;

  const Product({
    required this.id,
    required this.price,
    required this.title,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price']?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, price, title, thumbnail];
}
