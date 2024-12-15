import 'package:hive/hive.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

class CartService {
  final Box<CartProduct> _cartProductBox;

  CartService({required Box<CartProduct> cartProductBox}) : _cartProductBox = cartProductBox;

  List<CartProduct> loadCartProducts() {
    return _cartProductBox.values.toList();
  }

  Future<void> addCartProduct(CartProduct product) async {
    await _cartProductBox.add(product);
  }

  Future<void> removeCartProduct(int index) async {
    await _cartProductBox.deleteAt(index);
  }

  Future<void> updateCartProduct(CartProduct product, int index) async {
    _cartProductBox.putAt(index, product);
  }

  Future<void> clearCart() async {
    await _cartProductBox.clear();
  }
}
