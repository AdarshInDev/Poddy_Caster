import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/_components/colors.dart';
import 'package:podcast_app/_components/util_widgets.dart';
import 'package:podcast_app/authorization/sign_in.dart';
import 'package:podcast_app/_components/data_for_dynamic.dart';

class ForgetPassPage extends StatefulWidget {
  ForgetPassPage({Key? key}) : super(key: key);

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  late TextEditingController _forgetEmail;

  @override
  void initState() {
    _forgetEmail = TextEditingController();
    _forgetEmail.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: AppConfig.screenWidth,
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
                children: [
                  SizedBox(height: AppConfig.screenHeight * 0.25),
                  NormalText(
                    text: "Forget Password",
                    textColor: pWhite,
                    textSize: AppConfig.textSize24,
                    isBold: true,
                  ),
                  SizedBox(height: AppConfig.height10),
                  NormalText(
                    text:
                        "Enter your email address below.\nWe'll look for your account and send you a\npassword reset email.",
                    align: TextAlign.center,
                  ),
                  SizedBox(height: AppConfig.height30),
                  Container(
                    decoration: BoxDecoration(
                      color: pDeepPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: AppConfig.screenWidth - AppConfig.width50,
                    child: TextFormField(
                      controller: _forgetEmail,
                      cursorColor: pPrimaryTextColor,
                      style: TextStyle(color: pLightPrimary),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: pLightPrimary,
                          size: AppConfig.textSize18,
                        ),
                        suffixIcon: textController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(Icons.close, color: pLightPrimary),
                                onPressed: () {
                                  setState(() {
                                    textController.clear();
                                  });
                                },
                              ),
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                          fontFamily: 'CircularStd-Book',
                          color: pLightPrimary,
                          fontSize: AppConfig.textSize12,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: AppConfig.height20),
                  GradientButton(
                    "Send Password Reset",
                    () {},
                    isDisable: _forgetEmail.text.isEmail
                        //RegExp(r'^([a-z0-9]+)\@([a-z]+)\.([a-z]+)$')
                        //      .firstMatch()
                        ? true
                        : false,
                  ),
                ],
              ),
              SizedBox(height: AppConfig.height80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account? ",
                    style: TextStyle(
                      fontSize: AppConfig.textSize12,
                      color: pPrimaryTextColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignInPage());
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: pLightPink,
                        fontWeight: FontWeight.bold,
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
