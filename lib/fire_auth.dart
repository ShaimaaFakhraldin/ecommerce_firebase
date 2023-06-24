import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static Future<User?> register(
      {required String name,required String emailUser, required String passwordUser}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user;

    try{
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailUser, password: passwordUser);
      user = userCredential.user;
      user!.updateDisplayName(name);
      user.updatePhotoURL("");
      user.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch(e){
       print(e);
    }
    return user;


  }
  static Future<User?> login ({required String emailUser, required String passwordUser}) async{

    FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
    User? user ;
   try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: emailUser, password: passwordUser);
     user =  userCredential.user;
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
     }
   }catch( e){
     print(e);
   }

    return user ;
  }
}
