import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/view/home.dart';
import 'package:login/view/login.dart';
import 'package:login/view/sign%20up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/sign/sign_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth _auth= FirebaseAuth.instance;
  bool login=false;
  String name="";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await _auth.authStateChanges().listen((user)  {
    if (user != null) {
      login=true;
      String? jsonString = prefs.getString('list_of_lists'); // Retrieve the string
      if (jsonString != null){
        List list=jsonDecode(jsonString).cast<List<dynamic>>();
        for(int i=0;i<list.length;i++){
          if(user.email==list[i][1].toString())
            name=list[i][0].toString();
        }
      }
    }
  });
  print(login);

  /*BlocProvider(create: (BuildContext context)=>loginBloc());
  BlocProvider(create: (BuildContext context)=>SignBloc());*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  MultiBlocProvider(providers: [
      BlocProvider<loginBloc>(create: (BuildContext context)=>loginBloc()),
      BlocProvider<SignBloc>(create: (BuildContext context)=>SignBloc()),
    ],
    child:login?home_screen(name: name,):login_screen(),)
   /* home: login?BlocProvider(create: (BuildContext context)=>SignBloc(),child: sign_screen(),):
      BlocProvider(create: (BuildContext context)=>loginBloc(),child: login_screen(),),*/
  ));
}


