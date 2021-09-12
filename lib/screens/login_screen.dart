import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: Utils.scaffoldPadding(size),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/Logo/ftf_name.svg'),
              Column(
                children: [
                  Text(
                    'Sign In using',
                    style: Get.textTheme.subtitle1?.copyWith(
                      color: kTextColor[500],
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: size.height.twoPercent),
                  GestureDetector(
                    onTap: () => authenticationController.signInWithGoogle(),
                    child: Card(
                      shape: const StadiumBorder(),
                      color: kWhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: kWhiteColor,
                            child: SvgPicture.asset('assets/Logo/google.svg'),
                          ),
                          Text(
                            'Google',
                            style: Get.textTheme.headline5
                                ?.copyWith(color: kBlackColor),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
late String _email;
late String _password;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: Utils.scaffoldPadding(size),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: SvgPicture.asset('assets/Logo/ftf_name.svg'),
                ),
                Expanded(
                  flex: 4,
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmailField(),
                        PasswordField(),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MyButton(
                            label: 'Login',
                            onPressed: () {
                              if (loginFormKey.currentState!.validate()) {
                                loginFormKey.currentState!.save();
                                authenticationController.signInWithEmail(
                                    email: 'email', password: 'password');
                              }
                            },
                            buttonSize: ButtonSize.large,
                            isCTA: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _BuildOR(),
                ),
                Expanded(
                  flex: 2,
                  child: _SignInButtons(),
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: Get.textTheme.subtitle1,
                      ),
                    ),
                    GestureDetector(
                      child: RichText(
                        text: TextSpan(
                          style: Get.textTheme.subtitle1,
                          children: [
                            TextSpan(
                              text: "Don't have an Account? ",
                            ),
                            TextSpan(
                              text: " Sign Up",
                              style: Get.textTheme.subtitle1?.copyWith(
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInButtons extends StatelessWidget {
  _SignInButtons({
    Key? key,
  }) : super(key: key);

  final AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Sign In using',
          style: Get.textTheme.subtitle1?.copyWith(
            color: text[500],
            letterSpacing: 1.5,
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => authenticationController.signInWithGoogle(),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: white,
                child: SvgPicture.asset('assets/Logo/google.svg'),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: white,
              child: SvgPicture.asset('assets/Logo/facebook.svg'),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}

class _BuildOR extends StatelessWidget {
  const _BuildOR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Divider(
            color: text[700],
            thickness: 0.5,
            endIndent: size.width * 0.05,
          ),
        ),
        Text(
          ' OR ',
          style: Get.textTheme.subtitle1?.copyWith(
            color: text[500],
            letterSpacing: 1.5,
          ),
        ),
        Expanded(
          child: Divider(
            color: text[700],
            thickness: 0.5,
            indent: size.width * 0.05,
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelText(label: 'Email'),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          keyboardAppearance: Brightness.dark,
          style: Get.textTheme.subtitle1!.copyWith(color: black),
          validator: (value) {
            if ((value ?? '').isValidEmail()) return null;
            return 'Check your email';
          },
          onSaved: (value) {
            _email = value!;
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({Key? key}) : super(key: key);

  final AuthenticationController authenticationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelText(label: 'Password'),
        TextFormField(
          obscureText: authenticationController.hidePassword,
          keyboardType: TextInputType.visiblePassword,
          keyboardAppearance: Brightness.dark,
          style: Get.textTheme.subtitle1!.copyWith(color: black),
          onSaved: (value) {
            _password = value ?? '';
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: primary,
            ),
            suffixIcon: ClipRRect(
              borderRadius: Utils.largeRadius,
              child: GestureDetector(
                  child: Icon(
                    authenticationController.hidePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: text[500],
                  ),
                  onTap: () {
                    authenticationController.toggleHidePassword();
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

*/