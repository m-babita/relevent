import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:relevent/pages/bottom_nav.dart';
import 'package:relevent/utils/model.dart';
import 'package:relevent/utils/show_snackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //EMAIL Signup
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String role,
    required BuildContext context,
  }) async {
    try {
      UserCredential username = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = username.user;
      user!.updateDisplayName(name);
      await sendEmailVerification(context)
          .then((value) => {postDetailsToFirestore(name, email, role)})
          .then((value) =>
              Navigator.pushReplacementNamed(context, BottomNav.routeName));

      if (user != null) {
        await _auth.currentUser!.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //post detailes on firestore
  postDetailsToFirestore(String name, String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.name = name;
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.role = role;
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

//email login

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context).then((value) =>
            Navigator.pushReplacementNamed(context, BottomNav.routeName));
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

//email verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

//password reset
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => Navigator.pop(context));
      showSnackBar(context, 'Reset Link sent to your email!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

//google signin
  Future<void> signInWithGoogle(BuildContext context) async {
    String name, email;

    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope('https://www.googleapis.com/auth/gmail.labels');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          assert(user.uid != null);
          assert(user.email != null);
          assert(user.displayName != null);
          name = user.displayName!;
          email = user.email!;
          postDetailsToFirestore(name, email, 'participant');
        }

        Navigator.pushReplacementNamed(context, BottomNav.routeName);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
