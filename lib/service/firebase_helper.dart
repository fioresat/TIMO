// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirebaseHelper {
//   static Future<bool> login(String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//       if (e.code == 'user-not-found') {
//         print("Unknown user");
//       } else if (e.code == 'wrong-password') {
//         print("Wrong password");
//       }
//     } catch (e) {
//       print("Unknown error");
//     }
//     return false;
//   }
// }