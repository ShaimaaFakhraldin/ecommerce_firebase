import 'package:ecommerce_firebase/screens/auth/login_ui.dart';
import 'package:ecommerce_firebase/screens/auth/user_profile_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.red,
      title: Text("wellcame"),centerTitle: true,),
      drawer: Container(
        color: Colors.red,
        width: 250,
        child: Column(
          children: [
             const SizedBox(height: 50,) ,
            ListTile( title:const Text("Home" , style: TextStyle(color: Colors.white),), onTap: (){
              Navigator.pop(context);

            },),
         const    SizedBox(height: 10,),
            ListTile( title: const Text("Profile",style: TextStyle(color: Colors.white) ,) ,onTap: (){
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (con){ return  const  UserProfileUi();}));
            },),
           const  SizedBox(height: 10,),
            ListTile( title: Container(color: Colors.white,
                child:Text("Logout",style:
            TextStyle(color: Colors.red),)), onTap: () async {
               FirebaseAuth.instance.signOut().then((value) {
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                     (con){ return  const LoginUi();}), (route) => false);
               });

            },)  ,
           const  SizedBox(height: 10,)
          ],
        ),

      ),
    );
  }
}
