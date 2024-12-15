import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductListFetchRequested extends ProductEvent {}

class ProductListFetchMoreRequested extends ProductEvent {}
