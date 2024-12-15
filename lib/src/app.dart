import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_example/src/core/dependency_injection/service_locator.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/cart/cart_event.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_bloc.dart';
import 'package:shopping_app_example/src/features/home/bloc/product/product_event.dart';
import 'package:shopping_app_example/src/features/home/presentation/pages/home_page.dart';
import 'package:shopping_app_example/src/features/home/repositories/home_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(homeRepository: sl.get<HomeRepository>())..add(ProductListFetchRequested()),
        ),
        BlocProvider(
          create: (context) => CartBloc(homeRepository: sl.get<HomeRepository>())..add(CartProductsSubscriptionRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff62ad4e)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
