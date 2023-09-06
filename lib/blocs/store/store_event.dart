part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {
  const StoreEvent();
}

class StoreProductRequest extends StoreEvent{
  const StoreProductRequest();
}

class StoreProductAddedToCart extends StoreEvent{
  const StoreProductAddedToCart(this.cartId);

  final int cartId;
}

class StoreProductRemovedFromCart extends StoreEvent{
  const StoreProductRemovedFromCart(this.product);

  final Product product;
}

class StoreCartClicked extends StoreEvent{
  const StoreCartClicked({required this.isClicked});
  final bool isClicked ;
}

class StoreTabProductClicked extends StoreEvent{
  const StoreTabProductClicked({required this.index});
  final int index;
}

class StoreFavoriteClicked extends StoreEvent{
  const StoreFavoriteClicked({required this.product,required this.context});
  final Product product;
  final BuildContext context;
}

