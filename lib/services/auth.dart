import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _createUserFromFirebaseUser(UserCredential user){
    return user != null ? CustomUser(user.user!.uid) : null;
  }

  Future<CustomUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      print('Anonymous sign-in: $result');
      return _createUserFromFirebaseUser(result);
    } catch (e) {
      print('Anonymous sign-in error: $e');
      return null;
    }
  }
}