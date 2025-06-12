import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:firebase_auth_demo/utils/showOTPDialog.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    String? name,
    String? photoURL,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Save user data using UsuarioProvider
      // if (context.mounted) {
      //   final usuarioProvider = Provider.of<UsuarioProvider>(
      //     context,
      //     listen: false,
      //   );
      //   usuarioProvider.load();
      //   await usuarioProvider.save(formData);
      // }

      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with name and photoURL if provided
      if (name != null && name.isNotEmpty) {
        await userCredential.user?.updateDisplayName(name);
      }

      if (photoURL != null && photoURL.isNotEmpty) {
        await userCredential.user?.updatePhotoURL(photoURL);
      }

      // Optionally send email verification
      // await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message ?? 'Ocorreu um erro ao criar a conta.',
        // );
      }
    } catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   'Ocorreu um erro inesperado.',
        // );
      }
    }
  }

  Future<void> updateName({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message!,
        // );
      }
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //if (!user.emailVerified) {
      //  await sendEmailVerification(context);
      // restrict access to certain things using provider
      // transition to another page instead of home screen
      //}
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(context, e.message!);
      }
    }
  }

  Future<void> converterContaAnonimaEmPermanente({
    String? name,
    String? photoURL,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      if (name != null) {
        await _auth.currentUser!.updateDisplayName(name);
      }

      if (photoURL != null) {
        await _auth.currentUser!.updatePhotoURL(photoURL);
      }

      await _auth.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(context, e.message!);
      }
    }
  }

  //CREDENTIAL LOGIN
  Future<void> loginWithCredential({
    required AuthCredential credential,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithCredential(credential);
      if (!user.emailVerified) {
        //await sendEmailVerification(context);

        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(context, e.message!);
      }
    }
  }

  //TOKEN LOGIN
  Future<void> loginWithToken({
    required String token,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithCustomToken(token);
      if (!user.emailVerified) {
        //await sendEmailVerification(context);
        //_logou(user);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(context, e.message!);
      }
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      // showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      // showSnackBar(
      //   context,
      //   e.message!,
      // );
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope(
          'https://www.googleapis.com/auth/contacts.readonly',
        );

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
          UserCredential userCredential = await _auth.signInWithCredential(
            credential,
          );

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          if (userCredential.user != null) {
            if (userCredential.additionalUserInfo!.isNewUser) {}
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message!,
        // );
      }
    }
  }

  // ANONYMOUS SIGN IN
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message!,
        // );
      }
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message!,
        // );
      }
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // showSnackBar(
        //   context,
        //   e.message!,
        // );
      } // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
