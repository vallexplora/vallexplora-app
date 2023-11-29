import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  User get getCurrentUser => _firebaseAuth.currentUser!;

  Future<String> getUserUID() async {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Future<int> signUpWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential credentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      var db = FirebaseFirestore.instance;
      db.collection("users").doc(credentials.user!.uid).set({
        "displayName": displayName,
        "email": email,
        "roles": ["tourist"],
        //"photoURL": "",
      }).onError((e, _) => "Error writing document: $e");
      return 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      var db = FirebaseFirestore.instance;
      final docRef = db.collection("users").doc(credentials.user!.uid);

      return docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data["roles"].contains("tourist")) {
            return 0;
          } else {
            throw FirebaseAuthException(code: "unauthorized-user");
          }
        },
        onError: (e) => {throw e},
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 1;
      } else if (e.code == 'unauthorized-user') {
        return 2;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
    GoogleSignIn().signOut();
  }

  Future<int> singInWIthGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential credentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = credentials.user;
      bool isNewUser = credentials.additionalUserInfo!.isNewUser;
      if (isNewUser) {
        if (user != null) {
          var db = FirebaseFirestore.instance;
          db.collection("users").doc(user.uid).set({
            "displayName": user.displayName,
            "email": user.email,
            "roles": ["tourist"],
          }).onError((e, _) => "Error writing document: $e");
        }
      }

      return isNewUser ? 0 : 1;
    } catch (e) {
      return -1;
    }
  }

  Future<String> sendPasswordResetEmail(email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e.toString();
    }
    return "$email";
  }

  Future<bool> updatePassword(
      {required newPassword, required email, required password}) {
    var authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    return getCurrentUser
        .reauthenticateWithCredential(authCredential)
        .then((user) => user.user!
            .updatePassword(password)
            .then((value) => true)
            .onError((error, stackTrace) => false))
        .onError((error, stackTrace) => false);
  }

  Future<bool> updateEmail(
      {required newEmail, required email, required password}) {
    var authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    return getCurrentUser
        .reauthenticateWithCredential(authCredential)
        .then((user) => user.user!
            .updateEmail(newEmail)
            .then((value) => true)
            .onError((error, stackTrace) => false))
        .onError((error, stackTrace) => false);
  }
}
