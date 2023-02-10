import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{

  Future<UserCredential?> signup({required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        throw('Email already in use');
      }
    }

    return credential;
  }

  Future<UserCredential?> login({required String email, required String pass}) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw('Email not registered');
      } else if (e.code == 'wrong-password') {
        throw('Wrong password');
      }
    }

    return credential;
  }

  String autoLogin() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }

    return '';
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}