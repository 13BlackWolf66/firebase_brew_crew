import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/models/simple_user.dart';
import 'package:firebase_project/services/database.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SimpleUser _userFromFirebaseUser(User? user){
   return SimpleUser(uid: user?.uid ?? 'NoUser');
  } 

  Stream<SimpleUser>get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      return 'NoUser';
    }
  }
  
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      debugPrint(e.toString());
      return 'NoUser';
    }
  }

  Future registerWithEAP(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('0','new member',100);

      return _userFromFirebaseUser(user);
    }catch(e){
      debugPrint(e.toString());
      return 'NoUser';
    }
  }

  Future signInWithEAP(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user; 
      return _userFromFirebaseUser(user);
    }catch(e){
      debugPrint(e.toString());
      return 'NoUser';
    }
  }
  }

