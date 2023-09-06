part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class LoginUserNameChanged extends LoginEvent{
  final String username;
  LoginUserNameChanged({required this.username});
  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent{
  final String password;
  LoginPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent{
  LoginSubmitted({required this.username,required this.password});
  final String username;
  final String password;
  @override
  List<Object> get props => [username,password];
}

class LoginLoginLogoutPress extends LoginEvent {
  LoginLoginLogoutPress(this.isLogin);

  final bool isLogin;
}

class LoginGoBack extends LoginEvent{}
