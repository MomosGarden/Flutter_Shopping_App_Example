import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartProducts = context.select((CartBloc cartBloc) => cartBloc.state.products);
    final isProductInCart = cartProducts.any((element) => element.id == product.id);

    return CircleAvatar(
      backgroundColor: isProductInCart ? Colors.green : Colors.grey,
      radius: 20,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.add_shopping_cart_rounded),
        color: Colors.white,
        onPressed: () {
          if (isProductInCart) {
            context.read<CartBloc>().add(RemoveCartProductRequested(product.id));
          } else {
            context.read<CartBloc>().add(AddCartProductRequested(product));
          }
        },
      ),
    );
  }
}
