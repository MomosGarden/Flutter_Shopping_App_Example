import 'package:equatable/equatable.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';

class ProductListData extends Equatable {
  final List<Product> products;
  final int total;

  const ProductListData({required this.products, required this.total});

  factory ProductListData.fromJson(Map<String, dynamic> json) {
    return ProductListData(
      total: json['total'] ?? 0,
      products: (json['products'] as List).cast<Map<String, dynamic>>().map(Product.fromJson).toList(),
    );
  }

  @override
  List<Object?> get props => [products, total];
}
