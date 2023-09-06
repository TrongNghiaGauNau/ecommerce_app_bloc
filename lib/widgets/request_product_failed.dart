import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/store/store_bloc.dart';


class RequestProductFailed extends StatelessWidget{
  const RequestProductFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Problem loading products'),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton(
          onPressed: () {
            context.read<StoreBloc>().add(const StoreProductRequest());
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }
}