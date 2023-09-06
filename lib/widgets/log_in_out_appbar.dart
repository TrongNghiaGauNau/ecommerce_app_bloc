import 'package:ecommerce_app_bloc/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';


class LogInOutAppBar extends StatefulWidget{
  const LogInOutAppBar({super.key});

  @override
  State createState() {
    return _LogInOutAppBarState();
  }
}

class _LogInOutAppBarState extends State<LogInOutAppBar>{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current.isLogin != previous.isLogin && current.isLogin == false,
      listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Log out successfully')),
          );
      },
      builder: (context, state) {
        if(state.isLogin){
          return TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginLoginLogoutPress(false));
            },
            child: const Text('Log out', style: TextStyle(color: Colors.black),),
          );
        }
        return TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen(),));
          },
          child: const Text('Log in', style: TextStyle(color: Colors.black),),
        );
      },
    );
  }
}