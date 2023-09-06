import 'package:ecommerce_app_bloc/screens/product_detail.dart';
import 'package:ecommerce_app_bloc/screens/store_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/store/store_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _addToCart(int cartId) {
      context.read<StoreBloc>().add(StoreProductAddedToCart(cartId));
    }

    void _showMyDialogAddToCart() {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Product Status'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Product is already in Cart'),
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
    }

    final hasEmptyFavorite = context.select<StoreBloc, bool>(
      (value) => value.state.favoriteProducts.isEmpty,
    );
    return Scaffold(
      body: hasEmptyFavorite
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Your favorite is empty'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const StoreApp(),
                      ));
                    },
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            )
          : BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                return SizedBox(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: state.favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.favoriteProducts[index];
                      final inCart = state.cartIds.contains(product.id);

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(product: product),
                            ),
                          );
                        },
                        child: Hero(
                          tag: product.id,
                          child: Card(
                            key: ValueKey(product.id),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 100,
                                    child: Image.network(product.image),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  OutlinedButton(
                                    onPressed: inCart
                                        ? () => _showMyDialogAddToCart()
                                        : () => _addToCart(product.id),
                                    style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(10),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_shopping_cart),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Add to cart'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
