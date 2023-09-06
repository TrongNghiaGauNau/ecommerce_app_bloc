import 'package:ecommerce_app_bloc/models/product.dart';
import 'package:ecommerce_app_bloc/screens/product_detail.dart';
import 'package:ecommerce_app_bloc/blocs/store/store_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../widgets/bottom_appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateToProductDetail(Product product) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetail(product: product),
        ),
      );
    }

    final hasEmptyCart = context.select<StoreBloc, bool>(
      (value) => value.state.cartIds.isEmpty,
    );
    final cartProduct = context.select<StoreBloc, List<Product>>(
      (value) => value.state.products
          .where((product) => value.state.cartIds.contains(product.id))
          .toList(),
    );
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My cart'),
          ),
          body: hasEmptyCart
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Your cart is empty'),
                      const SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add Product'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartProduct.length,
                  itemBuilder: (context, index) {
                    final product = cartProduct[index];

                    return Container(
                      height: 110,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            //isChecked nên bằng giá trị check trong product
                            value: product.isChecked,
                            onChanged: (newBool) {
                              setState(() {
                                product.isChecked = newBool!;
                                context.read<CartBloc>().add(
                                    CartCheckBoxClicked(
                                        product.isChecked, product));
                              });
                            },
                            activeColor: Colors.deepOrange,
                          ),
                          InkWell(
                            onTap: () => navigateToProductDetail(product),
                            child: Container(
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.only(right: 15),
                              child: Image.network(product.image),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => navigateToProductDetail(product),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      product.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Price: ${product.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context.read<StoreBloc>().add(
                                        StoreProductRemovedFromCart(
                                            product));
                                    if (product.isChecked) {
                                      context.read<CartBloc>().add(
                                          CartRemoveButtonClicked(product));
                                    }
                                    // product.amountInCart = 0; ????
                                  },
                                  label: const Text('Remove from Cart'),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      // onTap: () => context.read<CartBloc>().add(CartIncreaseProductAmount(product.amountInCart)),
                                      onTap: () {
                                        setState(() {
                                          product.amountInCart++;
                                          // if (product.amountInCart > 10) {
                                          //   product.amountInCart--;
                                          // }
                                        });
                                        context.read<CartBloc>().add(
                                          CartIncreaseProductAmount(
                                              context,product),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                              ),
                                            ]),
                                        child: const Icon(
                                          CupertinoIcons.plus,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        product.amountInCart.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () => context.read<CartBloc>().add(CartDecreaseProductAmount(product.amountInCart)),
                                      onTap: () {
                                        setState(() {
                                          product.amountInCart--;
                                          // if (product.amountInCart < 0) {
                                          //   product.amountInCart++;
                                          // }
                                        });
                                        context.read<CartBloc>().add(
                                          CartDecreaseProductAmount(
                                              context,product),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                              ),
                                            ]),
                                        child: const Icon(
                                          CupertinoIcons.minus,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          bottomNavigationBar: hasEmptyCart
              ? null
              : CartBottomNavBar(amountOrders: state.orderList),
        );
      },
    );
  }
}
