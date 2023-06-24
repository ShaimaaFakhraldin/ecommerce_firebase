import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
// 01210387863

class UserProfileUi extends StatefulWidget {
  const UserProfileUi({super.key});

  @override
  State<UserProfileUi> createState() => _UserProfileUiState();
}

class _UserProfileUiState extends State<UserProfileUi> {
  User? user ;
  String imageUser  ="";
  @override
  void initState() {
    getCurrentUser ();
    super.initState();
  }

  getCurrentUser(){
    FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
    user = firebaseAuth.currentUser;
    setState(() {
      imageUser = user!.photoURL!;

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
        (appBar: AppBar(
          backgroundColor: Colors.red,
          title:  const Text("Profile"),centerTitle: true,) ,
      body: Center(
        child: Container(
          margin:  const EdgeInsets.symmetric(horizontal: 30),
          child:   SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                  InkWell(
                    onTap: (){
                      getImageFromGallary();
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: (imageUser==null)  ?
                          checkIfUrlIsValid(url: imageUser) ?  Image.network(
                            imageUser,
                            fit: BoxFit.fill,
                          ): Image.file(File(imageUser)) :
                          const Icon(Icons.person)


                        ),
                      ),
                    ),
                  ),
                    Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          uploadImage();
                        }, child: Text("Upload image")) ,

                        ElevatedButton(onPressed: (){
                          updatImage();
                        }, child: const Text("Update image"))
                      ],
                    )



                ],) ,


                const  Text("Name is :" ,style: TextStyle(color: Colors.red  ,fontSize: 30),) ,
                 const SizedBox(height: 5,),
                Text("${user!.displayName}" ,style:  const TextStyle(fontSize: 18),),
                const SizedBox(height: 20,),
                const  Text("Email is :" ,style:    TextStyle(color: Colors.red  ,fontSize: 30),) ,
                const SizedBox(height: 5,),
                Text("${user!.email}" ,style:      const TextStyle(fontSize: 18),),
                const SizedBox(height: 20,),
                const  Text("is  emailVerified :" ,style: TextStyle(color: Colors.red  ,fontSize: 30),) ,
                const SizedBox(height: 5,),
                Text("${user!.emailVerified}" ,style:  const TextStyle(fontSize: 18),),
                const SizedBox(height: 20,),
                const SizedBox(height: 20,),
                const  Text("phoneNumber is :  :" ,style: TextStyle(color: Colors.red  ,fontSize: 30),) ,
                const SizedBox(height: 5,),
                Text("${user!.phoneNumber}" ,style:  const TextStyle(fontSize: 18),),
                const SizedBox(height: 20,),
                const  Text("photoURL is :  :" ,style: TextStyle(color: Colors.red  ,fontSize: 30),) ,
                const SizedBox(height: 5,),
                Text("${user!.photoURL}" ,style:  const TextStyle(fontSize: 18),),

              ],
            ),
          ),
        ),
      ),
    );
  }
   updatImage () async {
     user!.updatePhotoURL("https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60");
     await user!.reload();
     FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
     user  =  firebaseAuth.currentUser  ;


   }
    uploadImage() async {
    print(imageUser);

     String imageName = basename(imageUser);
     print(imageName);
      final storage = FirebaseStorage.instance;
  UploadTask up=      storage.ref().child("photos").child(imageName).putFile(File(imageUser));
  up.snapshotEvents.listen((task) {
    switch (task.state)  {
      case TaskState.running:
        break;
      case TaskState.paused:

        break;
      case TaskState.success:

        up.snapshot.ref.getDownloadURL();


        break;
      case TaskState.canceled:

        break;
      case TaskState.error:

        break;
    }


  }


  );


    }
     getImageFromGallary() async {
       final ImagePicker picker = ImagePicker();
       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
       setState(() {
         imageUser = image!.path;
       });
     }



    bool checkIfUrlIsValid({required String url})  {
    if (Uri.tryParse(url)!.hasAbsolutePath) {
      return true;
    }
    return false;}

}
