import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/services/product/api/dtos/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Builder(
                builder: (context) {
                  final cartProducts = context
                      .select((CartBloc cartBloc) => cartBloc.state.products);
                  final isProductInCart =
                      cartProducts.any((element) => element.id == product.id);

                  return CircleAvatar(
                    backgroundColor:
                        isProductInCart ? Colors.green : Colors.grey,
                    radius: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      color: Colors.white,
                      onPressed: () {
                        if (isProductInCart) {
                          context
                              .read<CartBloc>()
                              .add(RemoveCartProductRequested(product.id));
                        } else {
                          context
                              .read<CartBloc>()
                              .add(AddCartProductRequested(product));
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
