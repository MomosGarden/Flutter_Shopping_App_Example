import 'package:shopping_app_example/src/core/network/dummy_client.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product_list_data.dart';

class ProductService {
  final DummyClient _dummyClient;

  ProductService({required DummyClient dummyClient}) : _dummyClient = dummyClient;

  Future<ProductListData> getProducts(int skip) async {
    final response = await _dummyClient.get(
      'products',
      queryParameters: {
        'limit': 20,
        'skip': skip,
      },
    );

    final productsData = ProductListData.fromJson(response.data as Map<String, dynamic>);

    return productsData;
  }
}
