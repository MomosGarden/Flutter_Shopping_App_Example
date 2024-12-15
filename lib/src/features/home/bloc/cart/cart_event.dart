import 'package:equatable/equatable.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartProductsSubscriptionRequested extends CartEvent {}

class AddCartProductRequested extends CartEvent {
  final Product product;

  const AddCartProductRequested(this.product);
}

class RemoveCartProductRequested extends CartEvent {
  final int productId;

  const RemoveCartProductRequested(this.productId);
}

class UpdateQuantityOfProductRequested extends CartEvent {
  final CartProduct product;

  const UpdateQuantityOfProductRequested(this.product);
}

class CheckOutRequested extends CartEvent {}
