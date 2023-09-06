part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = '',
    this.password = '',
    this.isLogin = false,
  });

  final String username;
  final String password;
  final bool isLogin;

  @override
  List<Object?> get props => [username,password,isLogin];

  LoginState copyWith({
    String? username,
    String? password,
    bool isLogin = false,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLogin: this.isLogin,
    );
  }
}

class LoginLoading extends LoginState{}
class LogOutLoading extends LoginState{}

class LoginSuccess extends LoginState{
  const LoginSuccess({
    this.username = '',
    this.password = '',
    this.isLogin = false,
  });

  final String username;
  final String password;
  final bool isLogin;

  @override
  List<Object?> get props => [username,password,isLogin];

  @override
  LoginSuccess copyWith({
    String? username,
    String? password,
    bool isLogin = false,
  }) {
    return LoginSuccess(
      username: username ?? this.username,
      password: password ?? this.password,
      isLogin: this.isLogin,
    );
  }
}
class LogOutSuccess extends LoginState{
  const LogOutSuccess({
    this.username = '',
    this.password = '',
    this.isLogin = false,
  });

  @override
  final String username;
  final String password;
  final bool isLogin;

  @override
  List<Object?> get props => [username,password,isLogin];

  @override
  LogOutSuccess copyWith({
    String? username,
    String? password,
    bool isLogin = false,
  }) {
    return LogOutSuccess(
      username: username ?? this.username,
      password: password ?? this.password,
      isLogin: this.isLogin,
    );
  }
}

class LoginFailed extends LoginState{}
class LogoutFailed extends LoginState{}


