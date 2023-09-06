import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_bloc/repository/store_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../models/product.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(const StoreState()) {
    on<StoreProductRequest>(_handleStoreProductRequested);
    on<StoreProductAddedToCart>(_handleStoreProductAddToCart);
    on<StoreProductRemovedFromCart>(_handleStoreRemoveFromCart);
    on<StoreCartClicked>(_handleStoreCartClicked);
    on<StoreTabProductClicked>(_handleStoreTabProductClicked);
    on<StoreFavoriteClicked>(_handleStoreFavoriteClicked);
  }

  final StoreRepository api = StoreRepository();

  Future<void> _handleStoreProductRequested(
    StoreProductRequest event,
    Emitter<StoreState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: StoreRequest.requestInProgress));

      final response = await api.getProduct();

      emit(
        state.copyWith(
            productStatus: StoreRequest.requestSuccess, products: response),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: StoreRequest.requestFailure),
      );
    }
  }

  Future<void> _handleStoreTabProductClicked(
    StoreTabProductClicked event,
    Emitter<StoreState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: StoreRequest.requestInProgress));

      late final List<Product> response;
      if (event.index == 0) {
        response = await api.getProduct();
      } else if (event.index == 1) {
        response = await api.getMenClothing();
      } else if (event.index == 2) {
        response = await api.getWomenClothing();
      } else if (event.index == 3) {
        response = await api.getJewelry();
      } else if (event.index == 4) {
        response = await api.getElectronics();
      }
      emit(
        state.copyWith(
            productStatus: StoreRequest.requestSuccess, tabProducts: response),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: StoreRequest.requestFailure),
      );
    }
  }

  Future<void> _handleStoreProductAddToCart(
    StoreProductAddedToCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cartIds: {...state.cartIds, event.cartId}));
  }

  Future<void> _handleStoreRemoveFromCart(
    StoreProductRemovedFromCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.product.id)));
    event.product.priceInCart = 0;
    event.product.amountInCart = 0;
  }

  Future<void> _handleStoreCartClicked(
      StoreCartClicked event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartClicked: event.isClicked));
  }

  Future<void> _handleStoreFavoriteClicked(
      StoreFavoriteClicked event, Emitter<StoreState> emit) async {
    if (state.favoriteProducts.contains(event.product)) {
      emit(state.copyWith(
          favoriteProducts:
              List.from(state.favoriteProducts)..remove(event.product),));
      ScaffoldMessenger.of(event.context).clearSnackBars();
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Text('Product is no longer a favorite'),
        ),
      );
    } else {
      emit(state.copyWith(
          favoriteProducts:
              List.from(state.favoriteProducts)..add(event.product),));
      ScaffoldMessenger.of(event.context).clearSnackBars();
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Text('Product has been added to favorite'),
        ),
      );
    }
  }
}
