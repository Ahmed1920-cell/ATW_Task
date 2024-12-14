import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class loginBloc extends Bloc<loginEvent, loginState> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  String name="";
  String errorMessage="";
  loginBloc() : super(loginInitial()) {
    on<loginEvent>((event, emit) async {
      if (event is Login) {
            try {
              UserCredential credential = await _auth
                  .signInWithEmailAndPassword(
                  email: event.userName, password: event.password);
              print("succes");
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              String? jsonString = prefs.getString('list_of_lists'); // Retrieve the string
              if (jsonString != null){
                List list=jsonDecode(jsonString).cast<List<dynamic>>();
                for(int i=0;i<list.length;i++){
                  if(event.userName==list[i][1].toString())
                    name=list[i][0].toString();
                }
              }
              print(name);
              emit(AuthLoaded(name));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-email') {
                errorMessage = "Your email is invalid";
                print('Invalid email');
              }
              if (e.code == 'user-not-found') {
                errorMessage = "User not found";
                print('Hi, User not found');
              } else if (e.code == 'wrong-password') {
                errorMessage = "Your password is not correct";
              }
else{
                errorMessage = "email and password are not correct";
              }
                print("////////////");
                print(e.code);
                print("/////////////");
              emit(loginError(errorMessage));
            }
          }
    });
  }
}