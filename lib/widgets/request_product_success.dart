import 'package:ecommerce_app_bloc/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app_bloc/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/store/store_bloc.dart';

class RequestProductSuccess extends StatelessWidget {
  const RequestProductSuccess({super.key});

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

    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return SizedBox(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: state.tabProducts.length,
            itemBuilder: (context, index) {
              final product = state.tabProducts[index];
              final inCart = state.cartIds.contains(product.id);

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: product),
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
                              // backgroundColor: inCart
                              //     ? const MaterialStatePropertyAll<Color>(Colors.grey)
                              //     : null,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: //inCart
                                  //     ? const [
                                  //   Icon(Icons.remove_shopping_cart),
                                  //   SizedBox(
                                  //     width: 10,
                                  //   ),
                                  //   Text('Remove from cart'),
                                  // ]
                                  [
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
    );
  }
}
