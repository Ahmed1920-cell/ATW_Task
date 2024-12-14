import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/login/login_bloc.dart';

class home_screen extends StatefulWidget {
  home_screen({super.key, this.name=""});
String name;
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

User? user;
  @override
  Widget build(BuildContext context) {
      return SafeArea(child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async {
              FirebaseAuth _auth= FirebaseAuth.instance;
              await _auth.signOut();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>BlocProvider<loginBloc>(create: (BuildContext context)=>loginBloc(),child: login_screen(),)));

            }, icon: Icon(Icons.logout))
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Hello: "+widget.name
,style: TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight: Radius.circular(30)),
          ),
          height: MediaQuery.sizeOf(context).height*3/4,
          child: Text("  Welcome in\n Home Screen"
            ,style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ));

  }
}
