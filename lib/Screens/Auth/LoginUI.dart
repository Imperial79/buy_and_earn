import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height15,
              Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              height20,
              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  width5,
                  TextButton(
                    onPressed: () {
                      navPush(context, RegisterUI());
                    },
                    child: Text(
                      "Register",
                    ),
                  ),
                ],
              ),
              kHeight(40),
              KTextfield.regular(
                context,
                keyboardType: TextInputType.number,
                label: "Phone",
              ),
              height20,
              KTextfield.regular(
                context,
                label: "Password",
                obscureText: true,
              ),
              height15,
              Row(
                children: [
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Help",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: KButton.full(
            onPressed: () {
              navPushReplacement(context, RootUI());
            },
            label: "Proceed",
          ),
        ),
      ),
    );
  }
}
