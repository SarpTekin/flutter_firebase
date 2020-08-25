import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser

  TheUser _fromFirebaseUser(User user){
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<TheUser> get user {
    return _auth.authStateChanges()
    .map(_fromFirebaseUser);
  }

  // Anon sign in
  Future signInAnon() async{
    await Firebase.initializeApp();
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _fromFirebaseUser(user) ;

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  // Sign out

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
      
    }

  }

  //email register

  Future registeredWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('name', 'surname', 'position');
      return _fromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }
// email sign in 

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _fromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }
}