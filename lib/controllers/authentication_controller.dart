import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  RxString userEmail = ''.obs;
  RxString userPassword = ''.obs;
  Rx<GoogleSignInAccount?> _googleAccount = Rx<GoogleSignInAccount?>(null);
  Rx<bool> _isLoggedIn = false.obs;
  RxBool _hidePassword = true.obs;

  GoogleSignInAccount? get googleAccount => _googleAccount.value;

  void setUserLoggedIn() => isLoggedIn = _firebaseAuth.currentUser != null;

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool value) => _isLoggedIn.value = value;

  set googleAccount(GoogleSignInAccount? account) =>
      _googleAccount.value = account;

  bool get hidePassword => _hidePassword.value;

  toggleHidePassword() {
    _hidePassword.value = !_hidePassword.value;
  }
  // -------------------- Sign in methods --------------------

  Future<UserCredential?> signInWithEmail(
      {required String? email, required String? password}) async {
    try {
      print("Signed in using Email and Password");
      return await _firebaseAuth.signInWithEmailAndPassword(
        // email: email!,
        // password: password!,
        email: 'test@test.com',
        password: 'test123',
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      _googleAccount.value = await _googleSignIn.signIn();

      if (_googleAccount.value != null) {
        final GoogleSignInAuthentication googleAuth =
            await _googleAccount.value!.authentication;

        final OAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print(
            "\n\nSigned in with Google --> ${_firebaseAuth.currentUser?.displayName}");
        setUserLoggedIn();
        return await _firebaseAuth.signInWithCredential(googleAuthCredential);
      }
      return null;
    } on PlatformException catch (e) {
      print("\n\nPlatformException --->" + e.message.toString());
      return null;
    } catch (e) {
      print("\n\nNo id selected -> $e");
      return null;
    }
  }
/*
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }
*/

  // -------------------- Sign up --------------------

  // Future<void> signUpWithEmail(
  //     {required String? email, required String? password}) async {
  //   try {
  //     UserCredential userCredential =
  //         await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email!,
  //       password: password!,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _googleAccount.value = await _googleSignIn.signOut();
    setUserLoggedIn();
  }
}
