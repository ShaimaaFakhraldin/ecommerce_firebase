import 'package:ecommerce_firebase/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_ui.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  String email = "";
  String password = "";
  User? user ;
  @override
  void initState() {
    getCurrentUser ();
    super.initState();
  }
  
   getCurrentUser(){
    FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
    user = firebaseAuth.currentUser;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.red,
      title:  const Text("Login"),centerTitle: true,),
      body:  Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user != null  ? " welcom ${user!.displayName }": "You have to login" , style:  TextStyle(fontSize: 30),),
             const SizedBox(height: 30,) ,
              // Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),

              // Password
              TextFormField(
                obscureText: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () async {
              User? user = await  FireAuth.login(emailUser: email, passwordUser: password);
               if(user != null){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (con){
                    return HomeUi(); }), (route) => false);
               }else {
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Check you info")));
               }
              }, child: const Text("Login"))
            ],
          ),
        ),
      ),
    
    
    
    );
  }
}
