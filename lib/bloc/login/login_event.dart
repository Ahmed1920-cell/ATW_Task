part of 'login_bloc.dart';

abstract class loginEvent {}

class Login extends loginEvent {
  final String userName;
  final String password;

  Login(this.userName, this.password);
}