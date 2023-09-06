part of 'store_bloc.dart';

enum StoreRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class StoreState {
  const StoreState({
    this.products = const [],
    this.favoriteProducts = const [],
    this.productStatus = StoreRequest.unknown,
    this.cartIds = const {},
    this.cartClicked = false,
    this.tabProducts = const [],
  });

  final List<Product> products;
  final List<Product> favoriteProducts;
  final StoreRequest productStatus;
  final Set<int> cartIds;
  final bool cartClicked;
  final List<Product> tabProducts;

  StoreState copyWith({
    final List<Product>? products,
    final List<Product>? favoriteProducts,
    final StoreRequest? productStatus,
    final Set<int>? cartIds,
    bool cartClicked = false,
    final List<Product>? tabProducts,
  }) =>
      StoreState(
        products: products ?? this.products,
        favoriteProducts: favoriteProducts ?? this.favoriteProducts,
        productStatus: productStatus ?? this.productStatus,
        cartIds: cartIds ?? this.cartIds,
        cartClicked: cartClicked,
        tabProducts: tabProducts ?? this.tabProducts,
      );
}
