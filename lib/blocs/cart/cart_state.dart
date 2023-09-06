part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    // this.checkAmount = 0,
    // this.cartList = const <int>[],
    this.orderList = const <Product>[],
    this.total = 0,
    // this.amountInCart = 0,
  });

  // final int checkAmount;
  // final List<int> cartList;
  final List<Product> orderList;
  final double total;

  // int amountInCart;

  CartState copyWith({
    // final int checkAmount = 0,
    // final List<int>? cartList,
    final List<Product>? orderList,
    final double? total,
    // int amountInCart = 0,
  }) =>
      CartState(
        // checkAmount: checkAmount,
        // cartList: cartList ?? this.cartList,
        orderList: orderList ?? this.orderList,
        total: total ?? this.total,
        // amountInCart: amountInCart,
      );

  @override
  List<Object?> get props => [orderList, total];
}

class RequestCartLoading extends CartState {}

class RequestCartSuccess extends CartState {}

class RequestCartFailed extends CartState {}
