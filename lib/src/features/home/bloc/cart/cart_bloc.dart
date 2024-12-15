import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_state.dart';
import 'package:shopping_app_example/src/features/home/repositories/home_repository.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final HomeRepository _homeRepository;

  CartBloc({required homeRepository})
      : _homeRepository = homeRepository,
        super(const CartState()) {
    on<CartProductsSubscriptionRequested>(_onCartProductsSubscriptionRequested);
    on<AddCartProductRequested>(
      _onAddCartProductRequested,
      transformer: droppable(),
    );
    on<RemoveCartProductRequested>(
      _onRemoveCartProductRequested,
      transformer: droppable(),
    );
    on<UpdateQuantityOfProductRequested>(
      _onUpdateQuantityOfProductRequested,
      transformer: droppable(),
    );
    on<CheckOutRequested>(
      _onCheckOutRequested,
      transformer: (events, mapper) => droppable<CheckOutRequested>().call(
        events.throttleTime(const Duration(milliseconds: 200)).flatMap(mapper),
        mapper,
      ),
    );
  }

  Future<void> _onCartProductsSubscriptionRequested(
    CartProductsSubscriptionRequested event,
    Emitter emit,
  ) async {
    await emit.onEach<List<CartProduct>>(
      _homeRepository.cartProducts,
      onData: (data) {
        emit(
          state.copyWith(
            products: data,
            status: data.isEmpty ? CartStatus.empty : CartStatus.hasProducts,
            total: data.fold(
              0,
              (sum, product) => sum! + (product.price * product.quantity),
            ),
          ),
        );
      },
      onError: (_, __) => emit(
        state.copyWith(
          status: CartStatus.failure,
        ),
      ),
    );
  }

  Future<void> _onAddCartProductRequested(
    AddCartProductRequested event,
    Emitter emit,
  ) async {
    await _homeRepository.addCartProduct(event.product);
  }

  Future<void> _onRemoveCartProductRequested(
    RemoveCartProductRequested event,
    Emitter emit,
  ) async {
    final index = state.products.indexWhere(
      (product) => product.id == event.productId,
    );

    await _homeRepository.removeCartProduct(index);
  }

  Future<void> _onUpdateQuantityOfProductRequested(
    UpdateQuantityOfProductRequested event,
    Emitter emit,
  ) async {
    final index = state.products.indexWhere(
      (product) => product.id == event.product.id,
    );

    if (event.product.quantity <= 0) {
      await _homeRepository.removeCartProduct(index);
      return;
    }

    await _homeRepository.updateCartProduct(
      event.product.copyWith(quantity: event.product.quantity),
      index,
    );
  }

  Future<void> _onCheckOutRequested(
    CheckOutRequested event,
    Emitter emit,
  ) async {
    if (state.status == CartStatus.empty) {
      return;
    }

    await _homeRepository.checkOutCart();

    emit(
      state.copyWith(
        status: CartStatus.checkOutDone,
      ),
    );
  }
}
