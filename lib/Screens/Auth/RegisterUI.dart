import 'dart:async';
import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/customer_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/notification_methods.dart';
import 'package:buy_and_earn/Screens/Auth/FlashPasswordUI.dart';
import 'package:buy_and_earn/Screens/Auth/LoginUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kOTPField.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final state = TextEditingController();
  final pincode = TextEditingController();
  final referCode = TextEditingController();
  Map<String, dynamic> referrerData = {};
  bool _isLoading = false;
  bool _otpLoading = false;
  Timer? _timer;
  final secondsProvider = StateProvider((ref) => 60);

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    city.dispose();
    state.dispose();
    pincode.dispose();
    referCode.dispose();
    if (_timer != null) _timer!.cancel();

    super.dispose();
  }

  _fetchReferrerData() async {
    setState(() => _isLoading = true);
    final res = await ref
        .read(authRepository)
        .fetchReferrerData({"referrerCode": referCode.text});
    if (!res.error) {
      referrerData = res.response;
    } else {
      referrerData = {};
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
    ref.read(secondsProvider.notifier).state = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (ref.read(secondsProvider) > 0) {
        setState(() {
          ref.read(secondsProvider.notifier).update(
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
      final fcmToken = ref.read(fcmTokenProvider);
      final res = await ref.read(authRepository).register({
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "state": state.text,
        "city": city.text,
        "pincode": pincode.text,
        "referrerCode": referCode.text,
        "fcmToken": fcmToken,
        "otp": otp
      });
      if (!res.error) {
        ref.read(customerProvider.notifier).state =
            CustomerModel.fromMap(res.response);
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
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height15,
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                height15,
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navPushReplacement(context, const LoginUI());
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
                KTextfield(
                  controller: name,
                  label: "Name",
                  keyboardType: TextInputType.name,
                  hintText: "Eg. John Doe",
                  validator: (val) {
                    if (val!.isEmpty) return "Required!";
                    return null;
                  },
                ).regular,
                height10,
                KTextfield(
                  controller: phone,
                  label: "Phone",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: "Eg. 909XXXXX85",
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required!";
                    } else if (val.length != 10) {
                      return "Length must be 10!";
                    }
                    return null;
                  },
                ).regular,
                height10,
                KTextfield(
                  controller: email,
                  label: "Email (Optional)",
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Eg. johndoe@mail.com",
                  validator: (val) => KValidation.email(val),
                ).regular,
                height10,
                KTextfield(
                  controller: state,
                  label: "State",
                  hintText: "Select State",
                ).dropdown(
                  dropdownMenuEntries: List.generate(
                    kStatesList.length,
                    (index) => DropdownMenuEntry(
                      label: kStatesList[index],
                      value: kStatesList[index],
                    ),
                  ),
                ),
                height10,
                Row(children: [
                  Flexible(
                    child: KTextfield(
                      controller: city,
                      label: "City",
                      keyboardType: TextInputType.text,
                      hintText: "Eg. Durgapur",
                      validator: (val) {
                        if (val!.isEmpty) return "Required!";
                        return null;
                      },
                    ).regular,
                  ),
                  width10,
                  Flexible(
                    child: KTextfield(
                      controller: pincode,
                      label: "Pincode",
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: "Eg. 7XXXX3",
                      validator: (val) {
                        if (val!.isEmpty || val.length != 6) return "Required!";
                        return null;
                      },
                    ).regular,
                  ),
                ]),
                height10,
                KTextfield(
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
                ).regular,
                height5,
                referrerData.isEmpty
                    ? const SizedBox.shrink()
                    : kCard(
                        child: Row(
                          children: [
                            referrerData['dp'] == null
                                ? CircleAvatar(
                                    child: Text("${referrerData['name'][0]}"),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(referrerData['dp']),
                                  ),
                            width10,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${referrerData['name']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "+91 ${referrerData['phone']}",
                                  style: const TextStyle(
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
          padding: const EdgeInsets.all(12),
          child: KButton(
            onPressed: () {
              // _sendOtp();
              _register("123456");
            },
            label: "Proceed",
          ).full,
        ),
      ),
    );
  }

  Widget confirmationOTPModal() {
    return Consumer(builder: (context, ref, child) {
      final seconds = ref.watch(secondsProvider);
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kRadius(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              height20,
              const Text(
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
                style: const TextStyle(fontSize: 15),
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
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          width10,
                          const Text("Sending OTP")
                        ],
                      )
                    : seconds != 0
                        ? Text("Resend after $seconds s")
                        : TextButton(
                            onPressed: () {
                              _resendOtp();
                            },
                            child: const Text("Resend OTP"),
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
