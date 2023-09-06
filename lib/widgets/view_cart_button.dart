import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';
import '../blocs/store/store_bloc.dart';
import '../screens/cart_screen.dart';
import '../screens/login_screen.dart';

class ViewCartButton extends StatelessWidget{
  const ViewCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    void _viewCart() {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: BlocProvider.value(
                value: context.read<StoreBloc>(),
                child: child,
              ),
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) =>
          const CartScreen(),
        ),
      );
    }

    return  Stack(
      clipBehavior: Clip.none,
      children: [
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state.cartClicked == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Login to view Cart')),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: state.isLogin
                    ? _viewCart
                    : () {
                  context
                      .read<StoreBloc>()
                      .add(const StoreCartClicked(isClicked: true));
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                tooltip: 'View Cart',
                child: const Icon(Icons.shopping_cart),
              );
            },
          ),
        ),
        BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state.cartIds.isEmpty) {
              return Positioned(
                right: -4,
                bottom: 40,
                child: Container(),
              );
            }
            return Positioned(
              right: -4,
              bottom: 40,
              child: CircleAvatar(
                backgroundColor: Colors.tealAccent,
                radius: 12,
                child: Text(state.cartIds.length.toString()),
              ),
            );
          },
        ),
      ],
    );
  }
}