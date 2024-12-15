import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app_example/src/app.dart';
import 'package:shopping_app_example/src/core/dependency_injection/service_locator.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(CartProductAdapter());
  await Hive.openBox<CartProduct>('cartProductBox');

  initializeDependencies();

  runApp(const App());
}
