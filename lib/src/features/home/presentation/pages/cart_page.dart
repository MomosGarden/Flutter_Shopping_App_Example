import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_state.dart';
import 'package:shopping_app_example/src/features/home/presentation/widgets/cart_list_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (BuildContext context, CartState state) {
        if (state.status == CartStatus.checkOutDone) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Order placed!'),
            ),
          ).then(
            (_) {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Cart',
            ),
          ),
          body: switch (state.status) {
            CartStatus.empty => const Center(
                child: Text(
                    'No products in cart. Please add what you want to buy.')),
            CartStatus.checkOutDone ||
            CartStatus.initial =>
              const Center(child: CircularProgressIndicator()),
            CartStatus.failure =>
              const Center(child: Text('Something went wrong.')),
            CartStatus.hasProducts => ListView.builder(
                itemCount: state.products.length + 1,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index >= state.products.length
                      ? SizedBox(height: 100)
                      : CartListItem(product: state.products[index]),
                ),
              ),
          },
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CheckoutButton(total: state.total),
          ),
        );
      },
    );
  }
}

class CheckoutButton extends StatelessWidget {
  final double total;

  const CheckoutButton({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        context.read<CartBloc>().add(CheckOutRequested());
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color(0xff62ad4e),
      height: 60,
      child: Row(
        children: [
          Text(
            '\$${total.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            'Checkout',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
