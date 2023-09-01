import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Future<String> getUserUID() async {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential credentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credentials.user?.updateDisplayName(displayName);
      return StringResources.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return StringResources.signUpErrorMessages["Weak"]!;
      } else if (e.code == 'email-already-in-use') {
        return StringResources.signUpErrorMessages["EmailTaken"]!;
      } else {
        return e.code;
      }
    } catch (e) {
      return "Exception: Authentication: $e";
    }
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return StringResources.loginSuccess(credentials.user!.displayName!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuario no encontrado.';
      } else if (e.code == 'wrong-password') {
        return 'Contraseña incorrecta.';
      } else {
        return e.code;
      }
    } catch (e) {
      return "Exception: Authentication: $e";
    }
  }

  Future<void> setUserDisplayName(User user, String displayName) async {
    // TODO: actually set up a method to add display name and user given user in firestore_resources.dart. This is just an infinite recursion.
    await setUserDisplayName(user, displayName);
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
    //  _googleSignIn.signOut();
  }

  Future<UserCredential> singInWIthGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> updatePassword(email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e.toString();
    }
    return "Correo de restablecimiento enviado a $email";
  }
}
