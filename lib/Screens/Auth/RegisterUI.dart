import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';

import '../../Utils/Common Widgets/kButton.dart';
import '../../Utils/Common Widgets/kTextfield.dart';
import '../../Utils/commons.dart';
import '../RootUI.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referCode = TextEditingController();

  _createAccount() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    referCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
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
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                height20,
                Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight(40),
                KTextfield.regular(
                  context,
                  label: "Name",
                  keyboardType: TextInputType.name,
                  hintText: "Eg. John Doe",
                  validator: (val) {
                    if (val!.isEmpty) return "Required!";
                    return null;
                  },
                ),
                height15,
                KTextfield.regular(
                  context,
                  label: "Phone",
                  keyboardType: TextInputType.phone,
                  hintText: "Eg. 90930***85",
                  validator: (val) {
                    if (val!.isEmpty)
                      return "Required!";
                    else if (val.length != 10) return "Length must be 10!";
                    return null;
                  },
                ),
                height15,
                KTextfield.regular(
                  context,
                  controller: password,
                  label: "Password",
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  hintText: "--------",
                  validator: (val) {
                    if (val!.isEmpty)
                      return "Required!";
                    else if (val != confirmPassword.text)
                      return "Password must be same as Confirm Password!";
                    return null;
                  },
                ),
                height15,
                KTextfield.regular(
                  context,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.visiblePassword,
                  label: "Confirm Password",
                  hintText: "Re-enter password",
                  validator: (val) {
                    if (val!.isEmpty)
                      return "Required!";
                    else if (val != password.text)
                      return "Confirm Password must be same as Password!";
                    return null;
                  },
                ),
                height15,
                KTextfield.regular(
                  context,
                  maxLength: 8,
                  textCapitalization: TextCapitalization.characters,
                  label: "Refer Code (Optional)",
                  hintText: "Eg. AJSH67GH",
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
                // _createAccount();
                navPushReplacement(context, RootUI());
              },
              label: "Proceed"),
        ),
      ),
    );
  }
}
