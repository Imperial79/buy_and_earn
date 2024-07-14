import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kOTPField.dart';
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
                  maxLength: 10,
                  hintText: "Eg. 90930***85",
                  validator: (val) {
                    if (val!.isEmpty)
                      return "Required!";
                    else if (val.length != 10) return "Length must be 10!";
                    return null;
                  },
                ),
                TextButton(onPressed: () {}, child: Text("Send OTP")),
                height10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter the OTP received on +91 ${phone.text}"),
                    height10,
                    Center(
                      child: KOtpField(
                        length: 6,
                      ),
                    ),
                  ],
                ),
                height15,
                KTextfield.regular(
                  context,
                  label: "Email (Optional)",
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Eg. johndoe@mail.com",
                ),
                height15,
                Row(
                  children: [
                    Expanded(
                      child: KTextfield.dropdown(
                        label: "State",
                        value: "West Bengal",
                        items: [
                          DropdownMenuItem(
                            value: "West Bengal",
                            child: Text("West Bengal"),
                          ),
                          DropdownMenuItem(
                            value: "Maharashtra",
                            child: Text("Maharashtra"),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    width10,
                    Expanded(
                      child: KTextfield.regular(
                        context,
                        label: "City",
                        keyboardType: TextInputType.text,
                        hintText: "Eg. Durgapur",
                        validator: (val) {
                          if (val!.isEmpty) return "Required!";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                height15,
                KTextfield.regular(
                  context,
                  maxLength: 8,
                  textCapitalization: TextCapitalization.characters,
                  label: "Refer Code (Optional)",
                  hintText: "Eg. AJSH67GH",
                ),
                height5,
                kCard(
                  child: Row(
                    children: [
                      CircleAvatar(),
                      width10,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jane Foster",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "+91 909****654",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ))
                    ],
                  ),
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
