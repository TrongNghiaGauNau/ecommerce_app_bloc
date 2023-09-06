import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/store/store_bloc.dart';
import '../models/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    void _addToCart(int cartId) {
      context.read<StoreBloc>().add(StoreProductAddedToCart(cartId));
    }

    void _removeFromCart() {
      context.read<StoreBloc>().add(StoreProductRemovedFromCart(product));
      if (product.isChecked) {
        context.read<CartBloc>().add(CartRemoveButtonClicked(product));
      }
    }

    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        final inCart = state.cartIds.contains(product.id);
        final isFavorite= state.favoriteProducts.contains(product);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Detail'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<StoreBloc>().add(
                      StoreFavoriteClicked(product: product,context: context));
                },
                icon: AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: animation,
                      child: child,
                    );
                  },
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFavorite
                    ?Icons.favorite
                    : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: product.id,
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 50.0,
                          height: 300,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Center(
                              child: Text('Price: ${product.price}',
                                  style: const TextStyle(
                                      fontFamily: 'Valera',
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFF17532))),
                            ),
                            const SizedBox(height: 20.0),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: SizedBox(
                                  height: 200,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width - 50.0,
                                  child: SingleChildScrollView(
                                    child: Text(product.description!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Valera',
                                            fontSize: 16.0,
                                            color: Color(0xFFB4B8B9))),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: inCart
                                    ? () {
                                  product.amountInCart = 0;
                                  _removeFromCart();
                                }
                                    : () => _addToCart(product.id),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: inCart
                                      ? const [
                                    Icon(Icons.remove_shopping_cart),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Remove from cart'),
                                  ]
                                      : const [
                                    Icon(Icons.add_shopping_cart),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Add to cart'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
