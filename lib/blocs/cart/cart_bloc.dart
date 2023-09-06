import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_bloc/blocs/store/store_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartCheckBoxClicked>(_handleCartCheckBoxClicked);
    on<CartRemoveButtonClicked>(_handleCartRemoveButtonClicked);
    on<CartIncreaseProductAmount>(_handleCartIncreaseProductAmount);
    on<CartDecreaseProductAmount>(_handleCartDecreaseProductAmount);
  }

  Future<void> _handleCartCheckBoxClicked(
    CartCheckBoxClicked event,
    Emitter<CartState> emit,
  ) async {
    if (event.checkBox == true) {
      event.product.priceInCart = _priceProductAmountInCart(event.product);
      //không sử dụng chung emit cho orderlist với total do total ko cập nhật kịp với orderlist
      emit(state.copyWith(
        orderList: List.from(state.orderList)..add(event.product),
      ));
      emit(state.copyWith(total: _totalPriceProducts(state.orderList),));
    } else {
      emit(state.copyWith(
        orderList: List.from(state.orderList)..remove(event.product),
      ));
      emit(state.copyWith(total: _totalPriceProducts(state.orderList),));
    }
  }

  Future<void> _handleCartRemoveButtonClicked(
    CartRemoveButtonClicked event,
    Emitter<CartState> emit,
  ) async {
    if (event.product.isChecked) {
      emit(state.copyWith(
        orderList: List.from(state.orderList)..remove(event.product),));
      emit(state.copyWith(total: _totalPriceProducts(state.orderList),));
      event.product.isChecked = false;
    }
  }

  Future<void> _handleCartIncreaseProductAmount(
    CartIncreaseProductAmount event,
    Emitter<CartState> emit,
  ) async {
    //trường hợp hết product trong store
    if (event.product.amountInCart > 10) {
      showDialog<void>(
        context: event.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Out of stock'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Not enough product in stock.'),
                  Text('Please choose another product hehe'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      event.product.amountInCart--;
    }
    //trường hợp bấm tăng số lượng khi đã tick vào checkbox
    if (event.product.isChecked) {
      event.product.priceInCart = _priceProductAmountInCart(event.product);
      emit(
        state.copyWith(total: _totalPriceProducts(state.orderList)),
      );
    }
    else{//trường hợp bấm tăng số lượng khi chưa tick vào checkbox
      event.product.priceInCart = _priceProductAmountInCart(event.product);
    }
    print(event.product.amountInCart);
  }

  Future<void> _handleCartDecreaseProductAmount(
    CartDecreaseProductAmount event,
    Emitter<CartState> emit,
  ) async {
    //trường hợp bấm giảm số lượng product xuống thấp hơn 0
    if(event.product.amountInCart < 0){
      showDialog<void>(
        context: event.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove from Cart'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Would you like to remove this item from Cart'),
                  Text('Click OK for Yes or No for Deny'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  context
                      .read<CartBloc>()
                      .add(CartRemoveButtonClicked(event.product));
                  context
                      .read<StoreBloc>()
                      .add(StoreProductRemovedFromCart(event.product));
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      event.product.amountInCart++;
    }
    //trường hợp bấm tăng số lượng khi đã tick vào checkbox
    if (event.product.isChecked) {
      event.product.priceInCart = _priceProductAmountInCart(event.product);
      emit(
        state.copyWith(total: _totalPriceProducts(state.orderList)),
      );
    }
    else{//trường hợp bấm tăng số lượng khi chưa tick vào checkbox
      event.product.priceInCart = _priceProductAmountInCart(event.product);
    }
  }

  double _totalPriceProducts(List<Product> orderList) {
    double totalPrice = 0;
    for (Product product in orderList) {
      totalPrice = totalPrice + product.priceInCart;
    }
    return totalPrice;
  }

  double _priceProductAmountInCart(Product product){
    double total = product.amountInCart * product.price;
    return total;
  }
}
