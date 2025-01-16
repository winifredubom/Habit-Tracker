import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// FirebaseAuth instance provider
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

// GoogleSignIn instance provider
final googleSignInProvider = Provider((ref) => GoogleSignIn());

// User state provider
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});



