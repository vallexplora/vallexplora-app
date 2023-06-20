import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Future<String> getUserUID() async {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Future<int> signUpWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential credentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // await setUserDisplayName(credentials.user!, displayName);
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return -1;
    } catch (e) {
      print("Exception: Authentication: $e");

      return -2;
    }
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return -1;
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
}
