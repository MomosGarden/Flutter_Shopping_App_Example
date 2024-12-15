import 'package:equatable/equatable.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

enum CartStatus {
  initial,
  empty,
  hasProducts,
  checkOutDone,
  failure,
}

class CartState extends Equatable {
  final List<CartProduct> products;
  final CartStatus status;
  final double total;

  const CartState({
    this.products = const [],
    this.status = CartStatus.initial,
    this.total = 0.0,
  });

  CartState copyWith({
    List<CartProduct>? products,
    CartStatus? status,
    double? total,
  }) {
    return CartState(
      products: products ?? this.products,
      status: status ?? this.status,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [products, status, total];
}
