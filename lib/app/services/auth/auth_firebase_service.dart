import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/core/ui/messages.dart';

class AuthFirebaseService {
  final FirebaseAuth _auth;
  AuthFirebaseService(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> registrarComEmail({
    String? name,
    String? photoURL,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (name != null && name.isNotEmpty) {
        await userCredential.user?.updateDisplayName(name);
      }

      if (photoURL != null && photoURL.isNotEmpty) {
        await userCredential.user?.updatePhotoURL(photoURL);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Messages.of(
          context,
        ).showError(e.message ?? 'Ocorreu um erro ao criar a conta.');
      }
    } catch (e) {
      if (context.mounted) {
        Messages.of(context).showError('Ocorreu um erro inesperado.');
      }
    }
  }

  Future<void> loginComEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Messages.of(context).showError(e.message!);
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
        Messages.of(context).showError(e.message!);
      }
    }
  }

  Future<void> loginAnonimo(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Messages.of(context).showError(e.message!);
      }
    }
  }

  Future<void> sair(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Messages.of(context).showError(e.message!);
      }
    }
  }
}
