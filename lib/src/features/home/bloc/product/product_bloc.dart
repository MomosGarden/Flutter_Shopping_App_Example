import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_event.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_state.dart';
import 'package:shopping_app_example/src/features/home/repositories/home_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeRepository _homeRepository;

  ProductBloc({required homeRepository})
      : _homeRepository = homeRepository,
        super(const ProductState()) {
    on<ProductListFetchRequested>(_onProductListFetchRequested);
    on<ProductListFetchMoreRequested>(
      _onProductListFetchMoreRequested,
      transformer: (events, mapper) =>
          droppable<ProductListFetchMoreRequested>().call(
        events.throttleTime(const Duration(milliseconds: 1000)).flatMap(mapper),
        mapper,
      ),
    );
  }

  Future<void> _onProductListFetchRequested(
    ProductListFetchRequested event,
    Emitter emit,
  ) async {
    try {
      final productsData = await _homeRepository.fetchProducts();

      emit(
        state.copyWith(
          products: productsData.products,
          status: ProductListStatus.success,
          total: productsData.total,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductListStatus.failure,
        ),
      );
    }
  }

  Future<void> _onProductListFetchMoreRequested(
    ProductListFetchMoreRequested event,
    Emitter emit,
  ) async {
    if (state.products.length >= state.total) {
      return;
    }

    try {
      emit(
        state.copyWith(
          status: ProductListStatus.loading,
        ),
      );

      final page = (state.products.length / 20).floor();

      final productsData = await _homeRepository.fetchProducts(skip: page * 20);

      emit(
        state.copyWith(
          products: [...state.products, ...productsData.products],
          status: ProductListStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductListStatus.failure,
        ),
      );
    }
  }
}
