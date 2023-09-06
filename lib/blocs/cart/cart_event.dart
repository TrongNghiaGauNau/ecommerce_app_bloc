part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartCheckBoxClicked extends CartEvent {
  CartCheckBoxClicked(this.checkBox, this.product);

  final bool checkBox;
  final Product product;
}

class CartRemoveButtonClicked extends CartEvent {
  CartRemoveButtonClicked(this.product);

  final Product product;
}

class CartIncreaseProductAmount extends CartEvent {
  CartIncreaseProductAmount(this.context,this.product);
  final BuildContext context;
  final Product product;
}

class CartDecreaseProductAmount extends CartEvent {
  CartDecreaseProductAmount(this.context,this.product);
  final BuildContext context;
  final Product product;
}
