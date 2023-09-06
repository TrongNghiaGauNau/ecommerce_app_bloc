import 'package:ecommerce_app_bloc/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app_bloc/repository/auth_repository.dart';
import 'package:ecommerce_app_bloc/screens/login_screen.dart';
import 'package:ecommerce_app_bloc/screens/store_app.dart';
import 'package:ecommerce_app_bloc/service/bloc_observer.dart';
import 'package:ecommerce_app_bloc/widgets/fix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/store/store_bloc.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 245, 107, 38),
  ),

);


void main() {
  Bloc.observer = MyGlobalObserver();
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => StoreBloc(),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Store Gau Nau',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const StoreApp(),
        ),
      ),
    );
  }
}
