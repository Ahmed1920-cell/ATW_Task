import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/login/login_bloc.dart';
import 'package:login/bloc/sign/sign_bloc.dart';
import 'package:login/view/login.dart';

import 'home.dart';

class sign_screen extends StatefulWidget {
  const sign_screen({super.key});

  @override
  State<sign_screen> createState() => _sign_screenState();
}

class _sign_screenState extends State<sign_screen> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool show_Password=false;
  IconData icon=Icons.visibility_off;

  String? _valid_name(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!RegExp(r"^[a-zA-Z][a-zA-Z0-9 ._]{2,19}$")
        .hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }
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
    return BlocConsumer<SignBloc, SignState>(
      listener: (context, state) async {
        if (state is SignLoaded) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context)=>BlocProvider<loginBloc>(create: (BuildContext context)=>loginBloc(),child: login_screen(),)));
        }
        else if(state is SignError){
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
                  Text("Sign up",style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: "Enter the Username",
                      labelText: "Username",
                    ),
                    controller: name,
                    validator: _valid_name,
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
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, proceed further
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logging in...')),
                            );
                            BlocProvider.of<SignBloc>(context)
                                .add(Sign(name.text, email.text,password.text));


                          }


                        }, child: Text("Sign up",style: TextStyle(color: Colors.black),)),
                  )
                ],
              ),
            ),
          ),
        ),
      );

    },
    );
    return Scaffold(
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
            Text("Sign up",style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: "Enter the Username",
                labelText: "Username",
              ),
              controller: name,
              validator: _valid_name,
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
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  onPressed: (){
              if (_formKey.currentState!.validate()) {
              // If the form is valid, proceed further
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in...')),
              );
              BlocProvider.of<SignBloc>(context)
                        .add(Sign(name.text, email.text,password.text));
              Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context)=>BlocProvider<loginBloc>(create: (BuildContext context)=>loginBloc(),child: login_screen(),)));

              }


              }, child: Text("Sign up",style: TextStyle(color: Colors.black),)),
            )
          ],
        ),
      ),
    ),
        );
  }
}
