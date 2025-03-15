import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // for storing data in cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for authentications
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // for registering user in firebase auth
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // for adding user to firebase
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          "email": email,
          'uid': credential.user!.uid,
        });
        res = "Successful";
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}
