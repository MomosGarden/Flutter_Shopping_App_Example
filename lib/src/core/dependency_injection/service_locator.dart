import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app_example/src/core/network/dummy_client.dart';
import 'package:shopping_app_example/src/features/home/repositories/home_repository.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';
import 'package:shopping_app_example/src/services/cart/cart_service.dart';
import 'package:shopping_app_example/src/services/product/product_service.dart';

final sl = GetIt.instance;

void initializeDependencies() async {
  sl.registerSingleton<DummyClient>(DummyClient());

  // Services
  sl.registerSingleton<ProductService>(
      ProductService(dummyClient: sl.get<DummyClient>()));
  sl.registerSingleton<CartService>(
      CartService(cartProductBox: Hive.box<CartProduct>('cartProductBox')));

  // Repositories
  sl.registerSingleton<HomeRepository>(HomeRepository(
    productService: sl.get<ProductService>(),
    cartService: sl.get<CartService>(),
  ));
}
