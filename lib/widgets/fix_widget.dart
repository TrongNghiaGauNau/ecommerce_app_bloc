import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';

class FixScreen extends StatelessWidget {
  const FixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final username = TextEditingController();
    final password = TextEditingController();
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          body: Stack(children: [
            Positioned(child:_top())
          ]),
        ),
      );
  }
}

Widget _top(){
  return Container(
    height: 200,
    child: Column(
      children: [
        Icon(Icons.shopping_cart,color: Colors.black,size: 100,),
        SizedBox(height:10),
        Text('Shop Gấu Nâu'),
      ],
    ),
  );
}
