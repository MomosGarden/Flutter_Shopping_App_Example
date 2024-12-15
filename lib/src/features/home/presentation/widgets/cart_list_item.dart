import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

class CartListItem extends StatelessWidget {
  final CartProduct product;

  const CartListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        spacing: 5,
        children: [
          CachedNetworkImage(
            imageUrl: product.thumbnail,
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
          Expanded(
            child: Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                              UpdateQuantityOfProductRequested(
                                product.copyWith(
                                    quantity: product.quantity - 1),
                              ),
                            );
                      },
                      icon: Icon(Icons.remove_circle_outline_sharp)),
                  Text(
                    product.quantity.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                              UpdateQuantityOfProductRequested(
                                product.copyWith(
                                    quantity: product.quantity + 1),
                              ),
                            );
                      },
                      icon: Icon(Icons.add_circle_outline_sharp)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
