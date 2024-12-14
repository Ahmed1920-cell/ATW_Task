
part of 'login_bloc.dart';


abstract class loginState {}

class loginInitial extends loginState {}



class AuthLoaded extends loginState {
  String username;
  AuthLoaded(
      this.username
      );

}

class loginError extends loginState {

  String error;
  loginError(
      this.error
      );
}