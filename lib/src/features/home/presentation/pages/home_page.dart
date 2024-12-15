import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_event.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_state.dart';
import 'package:shopping_app_example/src/features/home/presentation/pages/cart_page.dart';
import 'package:shopping_app_example/src/features/home/presentation/widgets/product_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );
        },
        child: const Icon(
          Icons.shopping_cart_checkout_outlined,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shopping App'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return switch (state.status) {
            ProductListStatus.initial =>
              const Center(child: CircularProgressIndicator()),
            ProductListStatus.failure => const Text('An error occurred'),
            ProductListStatus.loading ||
            ProductListStatus.success =>
              ListView.builder(
                controller: _scrollController,
                itemCount: state.status == ProductListStatus.success
                    ? state.products.length
                    : state.products.length + 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: index < state.products.length
                        ? ProductListItem(product: state.products[index])
                        : const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
          };
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductBloc>().add(ProductListFetchMoreRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
