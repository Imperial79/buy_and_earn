// ignore_for_file: unused_result
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Screens/ContactsUI.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Mobile_Plan_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mobile_Recharge_UI extends ConsumerStatefulWidget {
  final int providerId;
  final String providerName;
  final String providerImage;
  const Mobile_Recharge_UI({
    super.key,
    required this.providerId,
    required this.providerName,
    required this.providerImage,
  });

  @override
  ConsumerState<Mobile_Recharge_UI> createState() => _Mobile_Recharge_UIState();
}

class _Mobile_Recharge_UIState extends ConsumerState<Mobile_Recharge_UI> {
  final _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(context, title: "Mobile Recharge", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kPlanCard(
                  context,
                  providerImage: widget.providerImage,
                  providerName: widget.providerName,
                ),
                height20,
                Text("Enter or Select your phone number"),
                height10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: KTextfield.regular(
                        context,
                        controller: _phone,
                        prefixText: "+91",
                        keyboardType: TextInputType.phone,
                        hintText: "Enter phone number here",
                        maxLength: 10,
                        validator: (val) {
                          if (val!.isEmpty)
                            return "Required!";
                          else if (val.length != 10)
                            return "Length must be 10!";
                          return null;
                        },
                      ),
                    ),
                    width10,
                    IconButton(
                      onPressed: () async {
                        Map? contact =
                            await navPush(context, ContactsUI()) as Map?;

                        if (contact != null) {
                          String sanitized = contact['phone']
                              .toString()
                              .replaceFirst("91", "");

                          if (sanitized.length > 10) {
                            sanitized = sanitized.substring(1);
                          }

                          setState(() {
                            _phone.text = sanitized;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.contacts_rounded,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                height10,
                KButton.full(
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                        navPush(
                            context,
                            Mobile_Plan_UI(
                              providerId: widget.providerId,
                              providerName: widget.providerName,
                              providerImage: widget.providerImage,
                              phone: _phone.text,
                            ));
                    },
                    label: "Proceed"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
