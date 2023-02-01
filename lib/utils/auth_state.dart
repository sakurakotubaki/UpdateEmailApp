import 'package:email_update/ui/email_reset.dart';
import 'package:email_update/ui/signin_page.dart';
import 'package:email_update/utils/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthState, dynamic>((ref) {
  return AuthState(ref);
});

class AuthState extends StateNotifier<dynamic> {
  final Ref _ref;

  AuthState(this._ref) : super([]);
  // ユーザーの新規登録.
  Future<void> userSignUp(
      String emailC, String passwordC, BuildContext context) async {
    try {
      final credential = await _ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: emailC, password: passwordC);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmailRest()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('提供されたパスワードが弱すぎる。');
      } else if (e.code == 'email-already-in-use') {
        print('その電子メールにはすでにアカウントが存在します。');
      }
    } catch (e) {
      print(e);
    }
  }

  // ユーザーのログイン.
  Future<void> userSignIn(
      String emailC, String passwordC, BuildContext context) async {
    try {
      final credential = await _ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: emailC, password: passwordC);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmailRest()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('そのメールに該当するユーザーは見つかりませんでした。');
      } else if (e.code == 'wrong-password') {
        print('そのユーザーに対して提供されたパスワードが間違っている。');
      }
    }
  }

  // ユーザーのログアウト.
  Future<void> userSignOut(BuildContext context) async {
    final credential = await _ref.read(firebaseAuthProvider).signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  // ユーザーのメールアドレスの変更.
  Future<void> emailUpdate(String emailC) async {
    final ref =
        await _ref.read(firebaseAuthProvider).currentUser?.updateEmail(emailC);
  }
}
