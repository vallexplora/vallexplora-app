import 'package:cloud_firestore/cloud_firestore.dart';
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
      var db = FirebaseFirestore.instance;
      db.collection("users").doc(credentials.user!.uid).set({
        "displayName": displayName,
        "email": email,
        "roles": ["tourist"],
        //"photoURL": "",
      }).onError((e, _) => "Error writing document: $e");
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

      var db = FirebaseFirestore.instance;
      final docRef = db.collection("users").doc(credentials.user!.uid);

      return docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data["roles"].contains("tourist")) {
            return StringResources.loginSuccess(data["displayName"]);
          } else {
            throw FirebaseAuthException(code: "unauthorized-user");
          }
        },
        onError: (e) => {throw e},
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 'Usuario o contraseña incorrectos.';
      } else if (e.code == 'unauthorized-user') {
        return 'Usuario no encontrado.';
      } else {
        return e.code;
      }
    } catch (e) {
      return "Exception: Authentication: $e";
    }
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
    GoogleSignIn().signOut();
  }

  Future<String> singInWIthGoogle() async {
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

      if (credentials.additionalUserInfo!.isNewUser) {
        if (user != null) {
          var db = FirebaseFirestore.instance;
          db.collection("users").doc(user.uid).set({
            "displayName": user.displayName,
            "email": user.email,
            "roles": ["tourist"],
          }).onError((e, _) => "Error writing document: $e");
        }
      }

      return StringResources.loginSuccess(credentials.user!.displayName!);
    } catch (e) {
      return "$e";
    }
  }

  Future<String> updatePassword(email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e.toString();
    }
    return "Correo de restablecimiento enviado a $email";
  }

  User get getCurrentUser => _firebaseAuth.currentUser!;
}
