import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

class QuantityInput extends StatelessWidget {
  final CartProduct product;

  const QuantityInput({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            context.read<CartBloc>().add(
                  UpdateQuantityOfProductRequested(
                    product.copyWith(quantity: product.quantity - 1),
                  ),
                );
          },
          icon: Icon(Icons.remove_circle_outline_sharp),
        ),
        Text(
          product.quantity.toString(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<CartBloc>().add(
                  UpdateQuantityOfProductRequested(
                    product.copyWith(quantity: product.quantity + 1),
                  ),
                );
          },
          icon: Icon(Icons.add_circle_outline_sharp),
        ),
      ],
    );
  }
}
