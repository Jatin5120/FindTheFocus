// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  static final StorageController _storageController = Get.find();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RxString userEmail = ''.obs;
  final RxString userPassword = ''.obs;
  final Rx<GoogleSignInAccount?> _googleAccount =
      Rx<GoogleSignInAccount?>(null);
  final Rx<bool> _isLoggedIn = false.obs;
  final RxBool _hidePassword = true.obs;

  @override
  onInit() {
    super.onInit();
    isLoggedIn = _storageController.isUserLoggedIn;
  }

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

  Future<void> signInWithGoogle() async {
    try {
      final UserDataController userDataController = Get.find();

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

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(googleAuthCredential);

        userDataController.user = userCredential.user!;

        userDataController.isNewUser =
            userCredential.additionalUserInfo?.isNewUser ?? true;

        setUserLoggedIn();

        _storageController.writeUserLoggedIn(true);

        if (userDataController.isNewUser) {
          log("New User Added");
          FirebaseService.addNewUser();
        }
      }
    } on PlatformException catch (e) {
      print("\n\nPlatformException --->" + e.message.toString());
    } catch (e) {
      print("\n\nNo id selected -> $e");
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
