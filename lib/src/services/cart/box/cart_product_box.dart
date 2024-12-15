import 'package:hive/hive.dart';

part 'cart_product_box.g.dart';

@HiveType(typeId: 1)
class CartProduct {
  CartProduct({
    required this.id,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.quantity,
  });

  CartProduct copyWith({
    int? id,
    double? price,
    String? title,
    String? thumbnail,
    int? quantity,
  }) {
    return CartProduct(
      id: id ?? this.id,
      price: price ?? this.price,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      quantity: quantity ?? this.quantity,
    );
  }

  @HiveField(0)
  int id;

  @HiveField(1)
  double price;

  @HiveField(2)
  String title;

  @HiveField(3)
  String thumbnail;

  @HiveField(4)
  int quantity;
}
