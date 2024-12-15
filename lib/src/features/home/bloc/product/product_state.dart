import 'package:equatable/equatable.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';

enum ProductListStatus {
  initial,
  loading,
  failure,
  success,
}

class ProductState extends Equatable {
  final List<Product> products;
  final ProductListStatus status;
  final int total;

  const ProductState({
    this.products = const [],
    this.status = ProductListStatus.initial,
    this.total = 0,
  });

  ProductState copyWith({
    List<Product>? products,
    ProductListStatus? status,
    int? total,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [status, products];
}
