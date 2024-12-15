import 'package:rxdart/rxdart.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';
import 'package:shopping_app_example/src/services/cart/cart_service.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product_list_data.dart';
import 'package:shopping_app_example/src/services/product/product_service.dart';

class HomeRepository {
  final ProductService _productService;
  final CartService _cartService;

  final _cartProductSubject = BehaviorSubject<List<CartProduct>>.seeded(const []);

  HomeRepository({
    required ProductService productService,
    required CartService cartService,
  })  : _productService = productService,
        _cartService = cartService {
    final cartProducts = _cartService.loadCartProducts();
    if (cartProducts.isEmpty) return;

    _cartProductSubject.add(cartProducts);
  }

  Stream<List<CartProduct>> get cartProducts => _cartProductSubject.stream;

  Future<ProductListData> fetchProducts({int skip = 0}) {
    final productsData = _productService.getProducts(skip);

    return productsData;
  }

  Future<void> addCartProduct(Product product) async {
    await _cartService.addCartProduct(
      CartProduct(
        id: product.id,
        price: product.price,
        title: product.title,
        thumbnail: product.thumbnail,
        quantity: 1,
      ),
    );

    _cartProductSubject.add(_cartService.loadCartProducts());
  }

  Future<void> removeCartProduct(int index) async {
    await _cartService.removeCartProduct(index);

    _cartProductSubject.add(_cartService.loadCartProducts());
  }

  Future<void> updateCartProduct(CartProduct product, int index) async {
    await _cartService.updateCartProduct(product, index);

    _cartProductSubject.add(_cartService.loadCartProducts());
  }

  Future<void> checkOutCart() async {
    await _cartService.clearCart();

    _cartProductSubject.add(_cartService.loadCartProducts());
  }
}
