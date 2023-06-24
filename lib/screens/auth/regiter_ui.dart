import 'package:ecommerce_firebase/fire_auth.dart';
import 'package:ecommerce_firebase/screens/home_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  String name = "";

  String email = "";

  String password = "";

  String conPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Regiter user"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // user name
              TextFormField(
                decoration: InputDecoration(
                  hintText: "User Name",
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    name = value!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
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
                height: 10,
              ),
              //confirem  Password
              TextFormField(
                obscureText: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Confirem Password",
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    conPassword = value!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        conPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter your info")));
                    } else if (password != conPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("password note matches")));
                    } else {
                      User? user = await FireAuth.register(
                          name: name, emailUser: email, passwordUser: password);
                      if (user != null) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (con) {
                          return const HomeUi();
                        }), (route) => false);
                      }
                    }
                  },
                  child: Text("Sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
