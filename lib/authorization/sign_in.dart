import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/_components/colors.dart';
import 'package:podcast_app/_components/terms_of_service.dart';
import 'package:podcast_app/_components/util_function.dart';
import 'package:podcast_app/_components/util_widgets.dart';
import 'package:podcast_app/authorization/forget_password.dart';
import 'package:podcast_app/authorization/sign_up_page.dart';
import 'package:podcast_app/_components/data_for_dynamic.dart';
import 'package:podcast_app/redirecting_page/redirecting_page.dart';

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
  bool isLoading = false;

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

  Future signIn() async {
    dynamic ans = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passController.text.trim(),
    );
    pPrintLog("sign in data", ans);
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: AppConfig.screenHeight,
          decoration: BoxDecoration(
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
                            'assets/images/logo.png',
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
                  NormalText(text: "Login to continue Radio App"),
                  SizedBox(height: AppConfig.height20),
                  Container(
                    decoration: BoxDecoration(
                      color: pDeepPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: AppConfig.screenWidth - AppConfig.width50,
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: pLightPrimary),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: pPrimaryTextColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: pPrimaryTextColor,
                          size: 18,
                        ),
                        suffixIcon: _emailController.text.isEmpty
                            ? Container()
                            : IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: pPrimaryTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _emailController.clear();
                                  });
                                },
                              ),
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                          fontFamily: 'CircularStd-Book',
                          color: pPrimaryTextColor,
                          fontSize: AppConfig.textSize12,
                        ),
                      ),
                      // textInputAction: TextInputAction.next,
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
                      style: TextStyle(color: pLightPrimary),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: pPrimaryTextColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
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
                        hintText: "Password",
                        hintStyle: TextStyle(
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
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              value: value,
                              activeColor: pLightPink,
                              checkColor: pWhite,
                              shape: CircleBorder(),
                              onChanged: (value) {
                                setState(() {
                                  this.value = value!;
                                });
                              },
                            ),
                            NormalText(text: "Remeber me"),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.offAll(() => ForgetPassPage());
                          },
                          child: NormalText(
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
                      Get.offAll(() => RedirectingPage());
                    },
                    isDisable: false,
                    isLoading: isLoading,
                  ),
                  SizedBox(height: AppConfig.height20),
                  NormalText(text: "OR"),
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
                        text: "Don't have account?",
                        textSize: AppConfig.textSize12,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SignUpPage());
                        },
                        child: Text(
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
                  NormalText(
                    text: "By signing up you indicate that you have read and",
                    textSize: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                        text: "agreed to the Patch",
                        textSize: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(TermsOfService());
                        },
                        child: NormalText(
                          text: "Terms of Service",
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
    );
  }
}
