import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';
import '../widgets/text_filed_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget loading = Container();
    double w = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purpleAccent, Colors.pink],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: w,
                  height: 150, //chiều cao bằng 1/3 màn hình
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dog_go_shopping.jpg'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Shop Gau Nau',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // Form(
                      //   key: _formKey,
                      //   child: Column(
                      //     children: [
                      //       TextFormField(
                      //         controller: username,
                      //         decoration: const InputDecoration(
                      //           hintText: 'Username',
                      //           hintStyle: TextStyle(color: Colors.grey),
                      //         ),
                      //         onChanged: (value) => context
                      //             .read<LoginBloc>()
                      //             .add(LoginUserNameChanged(username: value)),
                      //         validator: (value) => value!.length > 3
                      //             ? null
                      //             : 'Username should be longer than 3 letters',
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       TextFormField(
                      //         controller: password,
                      //         decoration: const InputDecoration(
                      //           hintText: 'Password',
                      //           hintStyle: TextStyle(color: Colors.grey),
                      //         ),
                      //         obscureText: true,
                      //         onChanged: (value) => context
                      //             .read<LoginBloc>()
                      //             .add(LoginPasswordChanged(password: value)),
                      //         validator: (value) => value!.length > 6
                      //             ? null
                      //             : 'Password should be longer than 6 letters',
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(),
                      //     ),
                      //     const Text(
                      //       'Forgot your password',
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Center(
                      //   child: BlocConsumer<LoginBloc, LoginState>(
                      //     listener: (context, state) {
                      //       if (state is LoginLoading) {
                      //         loading = const CircularProgressIndicator();
                      //       }
                      //       if (state is LoginSuccess) {
                      //         Navigator.of(context).pop();
                      //       }
                      //       if (state is LoginFailed) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text('Error.Please login again'),
                      //           ),
                      //         );
                      //         loading = Container();
                      //       }
                      //     },
                      //     builder: (context, state) {
                      //       return Column(
                      //         children: [
                      //           ElevatedButton(
                      //             style: ElevatedButton.styleFrom(
                      //               backgroundColor: Colors.yellow,
                      //               elevation: 10,
                      //               padding: const EdgeInsets.all(20),
                      //             ),
                      //             onPressed: () {
                      //               if (_formKey.currentState!.validate()) {
                      //                 context.read<LoginBloc>().add(
                      //                       LoginSubmitted(
                      //                         username: username.text,
                      //                         password: password.text,
                      //                       ),
                      //                     );
                      //               }
                      //             },
                      //             child: const Text(
                      //               'Sign in',
                      //               style: TextStyle(color: Colors.red),
                      //             ),
                      //           ),
                      //           const SizedBox(height: 10,),
                      //           loading,
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
            height: 400,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.login),
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(LoginUserNameChanged(username: value)),
                          validator: (value) => value!.length > 3
                              ? null
                              : 'Username should be longer than 3 letters',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          obscureText: true,
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(password: value)),
                          validator: (value) => value!.length > 6
                              ? null
                              : 'Password should be longer than 6 letters',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: true , onChanged: (newValue){}),
                    const Text('Remember me'),
                    const SizedBox(width:  150,),
                    const Text(
                      'Forgot your password',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginLoading) {
                        loading = const CircularProgressIndicator();
                      }
                      if (state is LoginSuccess) {
                        Navigator.of(context).pop();
                      }
                      if (state is LoginFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error.Please login again'),
                          ),
                        );
                        loading = Container();
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              elevation: 10,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginSubmitted(
                                        username: username.text,
                                        password: password.text,
                                      ),
                                    );
                              }
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          loading,
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
