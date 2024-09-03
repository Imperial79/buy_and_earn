import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Models/user_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/notiification_methods.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUI extends ConsumerStatefulWidget {
  const LoginUI({super.key});

  @override
  ConsumerState<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends ConsumerState<LoginUI> {
  final _formKey = GlobalKey<FormState>();
  final phone = TextEditingController();
  final mpin = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // print(encryptDecryptText("encrypt", "1234"));
    print(encryptDecryptText("decrypt", "hFG8q/vivaVSKkMwojycrA=="));
  }

  @override
  void dispose() {
    phone.dispose();
    mpin.dispose();
    super.dispose();
  }

  _login() async {
    FocusScope.of(context).unfocus();
    try {
      setState(() => _isLoading = true);
      if (_formKey.currentState!.validate()) {
        final fcmToken = ref.read(fcmTokenProvider);
        final res = await ref.read(authRepository).login({
          "phone": phone.text,
          "mpin": mpin.text,
          "fcmToken": fcmToken,
        });
        if (!res.error) {
          ref.read(userProvider.notifier).state =
              UserModel.fromMap(res.response);
          navPopUntilPush(context, RootUI());
        }
        KSnackbar(context, content: res.message, isDanger: res.error);
      }
    } catch (e) {
      KSnackbar(context, content: "Something went wrong!", isDanger: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: _isLoading,
      loadingText: "Login in...",
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
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
                height15,
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Register",
                      ),
                    ),
                  ],
                ),
                height15,
                KTextfield.regular(
                  context,
                  controller: phone,
                  label: "Phone",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  prefixText: "+91",
                  hintText: "909XXXXX85",
                  validator: (val) {
                    if (val!.isEmpty)
                      return "Required!";
                    else if (val.length != 10) return "Length must be 10!";
                    return null;
                  },
                ),
                height10,
                KTextfield.regular(
                  context,
                  controller: mpin,
                  label: "Mpin",
                  obscureText: true,
                  hintText: "Enter your MPIN",
                  validator: (val) {
                    if (val!.isEmpty) return "Required!";
                    return null;
                  },
                ),
                height15,
                Row(
                  children: [
                    Text(
                      "Forgot Mpin ?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // navPush(context, HelpUI());
                      },
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: KButton.full(
            onPressed: () {
              _login();
            },
            label: "Log In",
          ),
        ),
      ),
    );
  }
}
