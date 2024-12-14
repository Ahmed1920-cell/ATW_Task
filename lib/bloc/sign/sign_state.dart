
part of 'sign_bloc.dart';


abstract class SignState {}

class SignInitial extends SignState {}

class SignLoading extends SignState {}

class SignLoaded extends SignState {
  final String username;

  SignLoaded(
      this.username,
      );
}

class SignError extends SignState {
  final String error;

  SignError(
      this.error,
      );

}