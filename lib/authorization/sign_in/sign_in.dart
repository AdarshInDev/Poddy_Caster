import 'package:flutter/material.dart';
import 'package:podcast_app/authorization/components/input_info_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF2D2C3C),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 30),
            Text(
              "Welcome Back!",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'CircularStd',
                fontSize: 24,
              ),
            ),
            Text(
              "Login to continue Radio App",
              style: TextStyle(
                color: Color(0xFF7B7B8B),
              ),
            ),
            SizedBox(height: 20),
            InputInfoTextField(
              text: "Email Address",
              icon: Icons.email_outlined,
              inType: TextInputType.text,
            ),
            SizedBox(height: 20),
            InputInfoTextField(
              text: "Password",
              icon: Icons.lock_outline,
              inType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
