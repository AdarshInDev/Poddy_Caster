import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poddy_caster/_components/colors.dart';
import 'package:poddy_caster/src/presentation/ui/terms_and_services/terms_of_service.dart';
import 'package:poddy_caster/src/utils/image_string.dart';
import 'package:poddy_caster/src/utils/data_for_dynamic.dart';
import 'package:poddy_caster/src/presentation/ui/home/redirecting_page.dart';
import 'package:poddy_caster/src/presentation/ui/auth/forget_password.dart';
import 'package:poddy_caster/src/presentation/ui/auth/sign_up_page.dart';
import 'package:poddy_caster/src/utils/important_functions.dart';
import 'package:poddy_caster/src/utils/util_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool value = false;
  bool isVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _emailController.addListener(() => setState(() {}));
    _passController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Visibility(
        child: SafeArea(
          child: Container(
            height: AppConfig.screenHeight,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 5,
                colors: [
                  ColorsForApp.backGradientColor1,
                  ColorsForApp.backGradientColor2
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: AppConfig.height30),
                    isKeyboard
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(
                                left: AppConfig.width50,
                                right: AppConfig.width50),
                            child: Image.asset(
                              logo,
                              fit: BoxFit.cover,
                            ),
                          ),
                    SizedBox(height: AppConfig.height30),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: pWhite,
                        fontSize: AppConfig.textSize24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const NormalText(text: "Login to continue Radio App"),
                    SizedBox(height: AppConfig.height20),
                    Container(
                      decoration: BoxDecoration(
                        color: pDeepPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: AppConfig.screenWidth - AppConfig.width50,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(color: pLightPrimary),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: pPrimaryTextColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: pPrimaryTextColor,
                            size: AppConfig.textSize18,
                          ),
                          hintText: "Type 'abhishek@gmail.com' to sign in",
                          hintStyle: TextStyle(
                            fontFamily: 'CircularStd-Book',
                            color: pPrimaryTextColor,
                            fontSize: AppConfig.textSize12,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(height: AppConfig.height20),
                    Container(
                      decoration: BoxDecoration(
                        color: pDeepPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: AppConfig.screenWidth - AppConfig.width50,
                      child: TextField(
                        controller: _passController,
                        obscureText: !isVisible,
                        style: const TextStyle(color: pLightPrimary),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: pPrimaryTextColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: pPrimaryTextColor,
                            size: 18,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                              color: pPrimaryTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                          hintText: "Type '123456' to sign in",
                          hintStyle: const TextStyle(
                            fontFamily: 'CircularStd-Book',
                            color: pPrimaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: AppConfig.width10 + 2,
                          right: AppConfig.width25 + 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                overlayColor: MaterialStateProperty.all(trans),
                                value: value,
                                activeColor: pLightPink,
                                checkColor: pWhite,
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  setState(() {
                                    this.value = value!;
                                  });
                                },
                              ),
                              const NormalText(text: "Remeber me"),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              navigateRoute(context, const ForgetPassPage());
                            },
                            child: const NormalText(
                              text: "Forget Password?",
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GradientButton(
                      "Log In",
                      () async {
                        _loading = true;
                        setState(() {
                          Timer(const Duration(seconds: 2), () {
                            setState(() {
                              _loading = false;
                            });
                          });
                        });
                        navigateRoute(context, const RedirectingPage());
                      },
                      isDisable: false,
                      isLoading: _loading,
                    ),
                    SizedBox(height: AppConfig.height20),
                    const NormalText(text: "OR"),
                    SizedBox(height: AppConfig.height20),
                    SignInSocial(
                      "Continue with Google",
                      () {},
                      "assets/images/google-png.png",
                      backColor: pWhite,
                      textColor: pBlack,
                    ),
                    SizedBox(height: AppConfig.height20),
                    SignInSocial(
                      'Continue with Facebook',
                      () {},
                      "assets/images/facebook.png",
                      textColor: pWhite,
                      backColor: pFB,
                    ),
                    SizedBox(height: AppConfig.height10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText(
                          text: "Don't have account? ",
                          textSize: AppConfig.textSize12,
                        ),
                        InkWell(
                          onTap: () {
                            navigateRoute(context, const SignUpPage());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: pLightPink,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const NormalText(
                      text: "By signing up you indicate that you have read and",
                      textSize: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const NormalText(
                          text: "agreed to the Patch",
                          textSize: 10,
                        ),
                        InkWell(
                          onTap: () {
                            navigateRoute(context, const TermsOfService());
                          },
                          child: const NormalText(
                            text: " Terms of Service",
                            textSize: 10,
                            textColor: pLightPink,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppConfig.height10),
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