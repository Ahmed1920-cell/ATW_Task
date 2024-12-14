part of 'sign_bloc.dart';
@immutable
abstract class SignEvent {}

class Sign extends SignEvent {
  final String Name;
  final String userName;
  final String password;

  Sign(this.Name,this.userName, this.password);
}