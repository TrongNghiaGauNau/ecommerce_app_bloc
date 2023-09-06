import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/store/store_bloc.dart';

class UnknownProductState extends StatelessWidget{
  const UnknownProductState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.shop_2_outlined,
            size: 60,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('No product to view'),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () {
              context.read<StoreBloc>().add(const StoreProductRequest());
              context.read<StoreBloc>().add(const StoreTabProductClicked(index: 0));
            },
            child: const Text('Load Products'),
          ),
        ],
      );
  }
}