import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../repository/auth_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginUserNameChanged>(_handleLoginUsernameChanged);
    on<LoginPasswordChanged>(_handleLoginPasswordChanged);
    on<LoginSubmitted>(_handleLoginSubmitted);
    on<LoginLoginLogoutPress>(_handleLoginLogoutPress);

  }

  Future<void> _handleLoginUsernameChanged(
    LoginUserNameChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(username: event.username));
  }

  Future<void> _handleLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(username: event.password));
  }

  final AuthRepository api = AuthRepository();

  Future<void> _handleLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 5));
      final login = await api.login();
      print(login);
      print(event.username);
      print(event.password );

      if(event.username == login[0] && event.password == login[1]){
        emit(state.copyWith(isLogin: true));
        emit(const LoginSuccess(isLogin: true));
      }else{
        emit(LoginFailed());

      }
    } catch (e) {
      emit(LoginFailed());
    }
  }

  Future<void> _handleLoginLogoutPress(
    LoginLoginLogoutPress event,
    Emitter<LoginState> emit,
  ) async {
    try {
      if(event.isLogin){
        emit(LogOutLoading());

        emit(state.copyWith(isLogin: event.isLogin));

        emit(LogOutSuccess(isLogin: event.isLogin));
      }else{
        emit(LogOutLoading());

        emit(state.copyWith(isLogin: event.isLogin));

        emit(LogOutSuccess(isLogin: event.isLogin));
      }
    } catch (e) {
      emit(LogoutFailed());
    }
  }

}
