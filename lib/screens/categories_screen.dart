import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/store/store_bloc.dart';
import '../widgets/request_product_failed.dart';
import '../widgets/request_product_success.dart';
import '../widgets/unknown_product_state.dart';
import 'package:ecommerce_app_bloc/widgets/tab_bar_products.dart';
class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( //Categories screen
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: const Text(
              'Shop Gấu Nâu',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
          ),
          const SizedBox(height: 10,),
          const TabBarProducts(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocConsumer<StoreBloc, StoreState>(
                listenWhen: (previous, current) =>
                previous.cartIds.length != current.cartIds.length,
                listener: (context, state) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Shopping Cart has been updated')),
                  );
                },
                builder: (context, state) {
                  if (state.productStatus == StoreRequest.requestInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.productStatus == StoreRequest.requestFailure) {
                    return const RequestProductFailed();
                  }
                  if (state.productStatus == StoreRequest.unknown) {
                    return const UnknownProductState();
                  }
                  //if(state.productStatus == StoreRequest.requestSuccess){
                  return const RequestProductSuccess();
                  //}
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}