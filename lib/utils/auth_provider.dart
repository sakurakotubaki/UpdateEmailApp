import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final emailProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final passwordProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});
