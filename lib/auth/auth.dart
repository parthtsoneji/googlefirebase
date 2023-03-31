import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlefirebase/Screen/signIn.dart';
import 'package:googlefirebase/Screen/signOut.dart';

class AuthService {
  handleState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SignOut();
        }
        else {
          return SignIn();
        }
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>['email']).signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!
        .authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
