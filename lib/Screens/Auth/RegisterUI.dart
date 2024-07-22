import 'dart:async';
import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/user_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/FlashPasswordUI.dart';
import 'package:buy_and_earn/Screens/Auth/LoginUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kOTPField.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  bool _otpLoading = false;
  late Timer _timer;
  final seconds = StateProvider((ref) => 60);

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    city.dispose();
    referCode.dispose();
    try {
      _timer.cancel();
    } catch (e) {}
    super.dispose();
  }

  _fetchReferrerData() async {
    setState(() => _isLoading = true);
    final res = await ref
        .read(authRepository)
        .fetchReferrerData({"referrerCode": referCode.text});
    if (!res.error) {
      referrerData = res.response;
    }
    setState(() => _isLoading = false);
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
          isDismissible: false,
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
      setState(() => _otpLoading = true);
      final res = await ref
          .read(authRepository)
          .sendOtp({"phone": phone.text, "otpType": "Register"});
      if (!res.error) {
        _startTimer();
      } else {
        Navigator.pop(context);
        KSnackbar(context, content: res.message, isDanger: res.error);
      }
      setState(() => _otpLoading = false);
    }
  }

  void _startTimer() {
    ref.read(seconds.notifier).state = 59;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (ref.read(seconds) > 0) {
        setState(() {
          ref.read(seconds.notifier).update(
                (state) => state -= 1,
              );
        });
      } else {
        timer.cancel();
      }
    });
  }

  _register(otp) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() => _isLoading = true);
      final res = await ref.read(authRepository).register({
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "state": _selectedState,
        "city": city.text,
        "referrerCode": referCode.text,
        "fcmToken": "",
        "otp": otp
      });
      if (!res.error) {
        ref.read(userProvider.notifier).state = UserModel.fromMap(res.response);
        navPopUntilPush(
            context,
            FlashPasswordUI(
              mpin: res.response['mpin'],
              tpin: res.response['tpin'],
            ));
      } else {
        KSnackbar(context, content: res.message, isDanger: res.error);
      }
      setState(() => _isLoading = false);
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
                height15,
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
                height15,
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
                height10,
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
                height10,
                KTextfield.regular(
                  context,
                  controller: email,
                  label: "Email (Optional)",
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Eg. johndoe@mail.com",
                ),
                height10,
                KTextfield.dropdown(
                  label: "State",
                  hintText: "Select State",
                  items: List.generate(
                    statesList.length,
                    (index) => DropdownMenuEntry(
                      label: "${statesList[index]}",
                      value: statesList[index],
                    ),
                  ),
                  onSelect: (value) {
                    setState(() {
                      _selectedState = value!;
                    });
                  },
                ),
                height10,
                KTextfield.regular(
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
                height10,
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
            label: "Proceed",
          ),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kRadius(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              height20,
              Text(
                "Verification",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              height10,
              Text(
                "Enter the OTP received on +91 ${phone.text}",
                style: TextStyle(fontSize: 15),
              ),
              kHeight(30),
              Center(
                child: KOtpField(
                  length: 6,
                  onCompleted: (otp) {
                    _register(otp);
                  },
                ),
              ),
              height20,
              Align(
                alignment: Alignment.topLeft,
                child: _otpLoading
                    ? Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          width10,
                          Text("Sending OTP")
                        ],
                      )
                    : _seconds != 0
                        ? Text("Resend after ${_seconds} s")
                        : TextButton(
                            onPressed: () {
                              _resendOtp();
                            },
                            child: Text("Resend OTP"),
                          ),
              ),
              height20,
            ],
          ),
        ),
      );
    });
  }
}
