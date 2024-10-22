import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/Auth/LoginUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePinsUI extends ConsumerStatefulWidget {
  const ChangePinsUI({super.key});

  @override
  ConsumerState<ChangePinsUI> createState() => _ChangePinsUIState();
}

class _ChangePinsUIState extends ConsumerState<ChangePinsUI> {
  bool isLoading = false;
  final _mpin_formKey = GlobalKey<FormState>();
  final _tpin_formKey = GlobalKey<FormState>();

  final currMpin = TextEditingController();
  final newMpin = TextEditingController();
  final currTpin = TextEditingController();
  final newTpin = TextEditingController();

  _changePin(String pinType) async {
    try {
      setState(() {
        isLoading = true;
      });

      final res = await ref.read(authRepository).changePins({
        "currTpin": currTpin.text.trim(),
        "newTpin": newTpin.text.trim(),
        "currMpin": currMpin.text.trim(),
        "newMpin": newMpin.text.trim(),
        "pinType": pinType,
      });

      if (!res.error && newMpin.text.isNotEmpty) {
        navPopUntilPush(context, const LoginUI())
            .then((value) => ref.read(customerProvider.notifier).state = null);
      }

      KSnackbar(context, content: res.message, isDanger: res.error);
    } catch (e) {
      KSnackbar(context, content: "Something went wrong!", isDanger: true);
    } finally {
      currMpin.clear();
      newMpin.clear();
      currTpin.clear();
      newTpin.clear();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    currMpin.dispose();
    newMpin.dispose();
    currTpin.dispose();
    newTpin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
      appBar: KAppBar(context, title: "change pins"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            children: [
              _MPIN_Form(),
              height20,
              _TPIN_Form(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _MPIN_Form() {
    return Form(
      key: _mpin_formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Change MPIN",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          height20,
          KTextfield(
            controller: currMpin,
            label: "Current MPIN",
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            hintText: "Enter current MPIN",
            validator: (val) {
              if (val!.isEmpty) {
                return "Required!";
              } else if (val.length < 4)
                return "Length must be greater than 3 chars!";
              return null;
            },
          ).regular,
          height20,
          KTextfield(
            controller: newMpin,
            label: "New MPIN",
            textCapitalization: TextCapitalization.none,
            obscureText: true,
            maxLength: 8,
            hintText: "Enter new MPIN",
            validator: (val) {
              if (val!.isEmpty) {
                return "Required!";
              } else if (val.length < 4)
                return "Length must be greater than 3 chars!";
              return null;
            },
          ).regular,
          height20,
          const Text(
              "Changing MPIN will log you out. You will need to login with your new credentials for verification."),
          height15,
          KButton(
            onPressed: () {
              if (_mpin_formKey.currentState!.validate()) _changePin("Mpin");
            },
            icon: const Icon(Icons.sync),
            backgroundColor: kSecondaryColor,
            label: "Update MPIN",
          ).withIcon,
        ],
      ),
    );
  }

  Widget _TPIN_Form() {
    return Form(
      key: _tpin_formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Change TPIN",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          height20,
          KTextfield(
            controller: currTpin,
            label: "Current TPIN",
            obscureText: true,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: "Enter current TPIN",
            validator: (val) {
              if (val!.isEmpty) {
                return "Required!";
              } else if (val.length != 6) return "Length must be 6";
              return null;
            },
          ).regular,
          height20,
          KTextfield(
            controller: newTpin,
            label: "New TPIN",
            obscureText: true,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: "Enter new TPIN",
            validator: (val) {
              if (val!.isEmpty) {
                return "Required!";
              } else if (val.length != 6) return "Length must be 6";
              return null;
            },
          ).regular,
          height20,
          const Text(
              "Changing TPIN will log you out. You will need to login with your new credentials for verification."),
          height15,
          KButton(
            onPressed: () {
              if (_tpin_formKey.currentState!.validate()) _changePin("Tpin");
            },
            icon: const Icon(Icons.sync),
            backgroundColor: kSecondaryColor,
            label: "Update TPIN",
          ).withIcon,
        ],
      ),
    );
  }
}
