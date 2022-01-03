// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:find_the_focus/constants/constants.dart';
import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  static final StorageController _storageController = Get.find();
  static final UserDataController _userDataController = Get.find();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Rx<GoogleSignInAccount?> _googleAccount =
      Rx<GoogleSignInAccount?>(null);
  final Rx<bool> _isLoggedIn = false.obs;
  final RxBool _isNewUser = true.obs;

  @override
  onReady() {
    super.onReady();
    ever(_isNewUser, _handleNewUser);
    ever(_isLoggedIn, _handleLogin);

    isNewUser = _storageController.isNewUser;
    isLoggedIn = _storageController.isUserLoggedIn;

    _userDataController.user = _firebaseAuth.currentUser;

    _firebaseAuth.authStateChanges().listen((user) {
      _userDataController.user = user;
      isLoggedIn = user != null;
    });
  }

  GoogleSignInAccount? get googleAccount => _googleAccount.value;
  set googleAccount(GoogleSignInAccount? account) =>
      _googleAccount.value = account;

  bool get isLoggedIn => _isLoggedIn.value;
  set isLoggedIn(bool value) => _isLoggedIn.value = value;

  bool get isNewUser => _isNewUser.value;
  set isNewUser(bool value) => _isNewUser.value = value;

  _handleLogin(bool loggedIn) {
    log("Handle login --> $loggedIn");
    if (loggedIn) {
      _handleNewUser(isNewUser);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  _handleNewUser(bool newUser) {
    log("Handle New User --> $newUser");
    if (newUser) {
      Get.offAllNamed(Routes.questions);
    } else {
      Get.offAllNamed(Routes.screenWrapper);
    }
  }

  void _login() {
    isLoggedIn = true;
    log("Login = true");
    _storageController.writeUserLoggedIn(true);
  }

  void _logout() {
    isLoggedIn = false;
    _storageController.writeUserLoggedIn(false);
  }
  // -------------------- Sign in methods --------------------

  Future<void> signInWithGoogle() async {
    try {
      googleAccount = await _googleSignIn.signIn();

      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleAccount!.authentication;

        final OAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        log("Signed in with Google --> ${_firebaseAuth.currentUser?.displayName}");

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(googleAuthCredential);

        _userDataController.user = userCredential.user!;

        isNewUser = userCredential.additionalUserInfo?.isNewUser ?? true;

        _login();

        if (isNewUser) {
          log("New User Added");
          FirebaseService.addNewUser();
        }
      } else {}
    } on PlatformException catch (e) {
      print("PlatformException --> " + e.message.toString());
    } catch (e) {
      print("No id selected -> $e");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _googleAccount.value = await _googleSignIn.signOut();
    _logout();
  }
}
