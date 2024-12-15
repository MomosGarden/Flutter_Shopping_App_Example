import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/features/home/presentation/widgets/quantity_input.dart';
import 'package:shopping_app_example/src/services/cart/box/cart_product_box.dart';

class CartListItem extends StatelessWidget {
  final CartProduct product;

  const CartListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                width: 130,
                fit: BoxFit.fitWidth,
                imageUrl: product.thumbnail,
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
              SizedBox(width: 3),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  QuantityInput(product: product),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                context.read<CartBloc>().add(RemoveCartProductRequested(product.id));
              },
              icon: Icon(
                Icons.cancel_outlined,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
