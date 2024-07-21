import 'dart:async';

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/LoginUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kOTPField.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Utils/Common Widgets/kButton.dart';
import '../../Utils/Common Widgets/kTextfield.dart';
import '../../Utils/commons.dart';

class RegisterUI extends ConsumerStatefulWidget {
  const RegisterUI({super.key});

  @override
  ConsumerState<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends ConsumerState<RegisterUI> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final city = TextEditingController();
  final referCode = TextEditingController();
  Map<String, dynamic> referrerData = {};
  String _selectedState = "Gujarat";
  bool _isLoading = false;
  late Timer _timer;
  final seconds = StateProvider((ref) => 60);

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    city.dispose();
    referCode.dispose();
    super.dispose();
  }

  _fetchReferrerData() async {
    setState(() => _isLoading = true);
    final res = await ref
        .read(authRepository)
        .fetchReferrerData({"referrerCode": referCode.text});
    if (!res.error) {
      referrerData = res.response;
      setState(() => _isLoading = false);
    }
  }

  _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final res = await ref
          .read(authRepository)
          .sendOtp({"phone": phone.text, "otpType": "Register"});
      if (!res.error) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: true,
          builder: (BuildContext context) {
            return confirmationOTPModal();
          },
        );
        _startTimer();
      } else {
        KSnackbar(context, content: res.message, isDanger: res.error);
      }
      setState(() => _isLoading = false);
    }
  }

  _resendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final res = await ref
          .read(authRepository)
          .sendOtp({"phone": phone.text, "otpType": "Register"});
      if (!res.error) {
        _startTimer();
      } else {
        KSnackbar(context, content: res.message, isDanger: res.error);
      }
      setState(() => _isLoading = false);
    }
  }

  void _startTimer() {
    ref.read(seconds.notifier).state = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (ref.read(seconds) > 0) {
        setState(() {
          ref.read(seconds.notifier).update(
                (state) => state -= 1,
              );
        });
      } else {
        timer.cancel();
        // Handle the timer completion here, if needed
        print('Countdown finished!');
      }
    });
  }

  _createAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final res = await ref
          .read(authRepository)
          .fetchReferrerData({"referrerCode": referCode.text});
      if (!res.error) {
        referrerData = res.response;
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: _isLoading,
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
                        navPush(context, LoginUI());
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
                height20,
                KTextfield.regular(
                  context,
                  controller: name,
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
                  controller: phone,
                  label: "Phone",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  hintText: "Eg. 909*****85",
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
                  controller: email,
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
                        value: _selectedState,
                        items: List.generate(
                          statesList.length,
                          (index) => DropdownMenuItem(
                            value: statesList[index],
                            child: Text("${statesList[index]}"),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedState = value!;
                          });
                        },
                      ),
                    ),
                    width10,
                    Expanded(
                      child: KTextfield.regular(
                        context,
                        controller: city,
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
                  controller: referCode,
                  maxLength: 8,
                  textCapitalization: TextCapitalization.characters,
                  label: "Refer Code",
                  hintText: "Eg. AJSH67GH",
                  onChanged: (value) {
                    if (value.length == 8) {
                      FocusScope.of(context).unfocus();
                      _fetchReferrerData();
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) return "Required!";
                    return null;
                  },
                ),
                height5,
                referrerData.isEmpty
                    ? SizedBox.shrink()
                    : kCard(
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text("${referrerData['name'][0]}"),
                            ),
                            width10,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${referrerData['name']}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "+91 ${referrerData['phone']}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
                _sendOtp();
              },
              label: "Proceed"),
        ),
      ),
    );
  }

  Widget confirmationOTPModal() {
    return Consumer(builder: (context, ref, child) {
      final _seconds = ref.watch(seconds);
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 250,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Enter the OTP received on +91 ${phone.text}"),
              height10,
              Center(
                child: KOtpField(
                  length: 6,
                  onCompleted: (otp) {},
                ),
              ),
              _seconds != 0
                  ? Text("${_seconds}")
                  : TextButton(
                      onPressed: () {
                        _resendOtp();
                      },
                      child: Text("Send OTP"),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
