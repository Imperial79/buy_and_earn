import 'package:buy_and_earn/Models/customer_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/notification_methods.dart';
import 'package:buy_and_earn/Screens/Auth/RegisterUI.dart';
import 'package:buy_and_earn/Screens/More/HelpUI.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool showPassword = false;

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
          ref.read(customerProvider.notifier).state =
              CustomerModel.fromMap(res.response);
          navPopUntilPush(context, const RootUI());
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
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("https://wa.me/7454038717"));
                      },
                      child: SvgPicture.asset(
                        "assets/icons/whatsapp.svg",
                        height: 40,
                      ),
                    )
                  ],
                ),
                height15,
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    width5,
                    TextButton(
                      onPressed: () {
                        navPushReplacement(context, const RegisterUI());
                      },
                      child: const Text(
                        "Register",
                      ),
                    ),
                  ],
                ),
                height15,
                KTextfield(
                  controller: phone,
                  label: "Phone",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  prefixText: "+91",
                  hintText: "909XXXXX85",
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
                  controller: mpin,
                  label: "Mpin",
                  textCapitalization: TextCapitalization.none,
                  obscureText: !showPassword,
                  hintText: "Enter your MPIN",
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      !showPassword ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return "Required!";
                    return null;
                  },
                ).regular,
                height15,
                Row(
                  children: [
                    const Text(
                      "Forgot Mpin ?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navPush(context, const HelpUI());
                      },
                      child: const Text(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: KButton(
            onPressed: () {
              _login();
            },
            label: "Log In",
          ).full,
        ),
      ),
    );
  }
}
