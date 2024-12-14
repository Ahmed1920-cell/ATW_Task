import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sin_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  FirebaseAuth _auth=FirebaseAuth.instance;
   List<String> data=[];
   String errorMessage="";
  SignBloc() : super(SignInitial()) {
    on<SignEvent>((event, emit) async {
      if (event is Sign)  {
       try {
         UserCredential credential = await _auth.createUserWithEmailAndPassword(email:event.userName, password:event.password );
         final SharedPreferences prefs = await SharedPreferences.getInstance();
         data=[event.Name,event.userName,event.password];
         String? jsonString = prefs.getString('list_of_lists'); // Retrieve the string
         if (jsonString != null){
         List list=jsonDecode(jsonString).cast<List<dynamic>>();
         list.add(data);
         String jsonstring = jsonEncode(list); // Convert to JSON string
         await prefs.setString('list_of_lists', jsonstring);
         }
         else{
           List<List> list=[];
           list.add(data);
           String jsonstring = jsonEncode(list); // Convert to JSON string
           await prefs.setString('list_of_lists', jsonstring);
         }
           emit(SignLoaded(event.Name));
       }on FirebaseAuthException catch (e){
         if (e.code == 'invalid-email') {
           errorMessage = "Your email is invalid";
           print('Invalid email');
         }
         if (e.code == 'email-already-in-use') {
           errorMessage = "email is already";
           print('Hi, User not found');
         } else if (e.code == 'weak-password') {
           errorMessage = "Your password is weak";
         }

         emit(SignError(errorMessage));}
        }
      }
    );
  }
}