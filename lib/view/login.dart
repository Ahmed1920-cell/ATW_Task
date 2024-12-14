import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/view/home.dart';
import 'package:login/view/sign%20up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/sign/sign_bloc.dart';


class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String er="";
bool show_Password=false;
IconData icon=Icons.visibility_off;
  String? valid_email(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  String? valid_password(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<loginBloc, loginState>(
        listener: (context, state) async {
      if (state is AuthLoaded) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context)=>home_screen(name: state.username,)));
      }
      else if(state is loginError){
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(state.error)),
        );
      }
    }, builder: (BuildContext context,  state) {

            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.orange,
                body: Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight: Radius.circular(30)),
                  ),
                  height: MediaQuery.sizeOf(context).height*3/4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("login",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: "Enter the email",
                            labelText: "email",

                          ),
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                            validator: valid_email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            hintText: "Enter the password",
                            labelText: "Password",
                            prefix: IconButton(onPressed:(){
                              setState(() {
                                if(!show_Password){
                                  icon=Icons.visibility;
                                  show_Password=true;
                                }
                                else{
                                  icon=Icons.visibility_off;
                                  show_Password=false;
                                }
                              });
                            } , icon: Icon(icon))
                          ),
                          controller: password,
                          validator: valid_password,
                          keyboardType: TextInputType.text,
                          obscureText:!show_Password ,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, proceed further
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logging in...')),
                            );
                            BlocProvider.of<loginBloc>(context)
                                .add(Login(email.text,password.text));
                            // Add login logic here
                          }



                        }, child: Text("Login",style: TextStyle(color: Colors.black))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("I don't have already account?"),
                            TextButton(onPressed: (){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context)=>
                                  BlocProvider<SignBloc>(create: (BuildContext context)=>SignBloc(),child: sign_screen(),)
                                  ));
                            }, child: Text("Register",style: TextStyle(color: Colors.blue),)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

    },
    );
  }
}
