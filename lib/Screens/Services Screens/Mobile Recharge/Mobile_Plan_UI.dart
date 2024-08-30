import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Mobile%20Recharge/Mobile_Checkout_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mobile_Plan_UI extends ConsumerStatefulWidget {
  final Mobile_Recharge_Modal masterdata;
  const Mobile_Plan_UI({
    super.key,
    required this.masterdata,
  });

  @override
  ConsumerState<Mobile_Plan_UI> createState() => _Mobile_Plan_UIState();
}

class _Mobile_Plan_UIState extends ConsumerState<Mobile_Plan_UI> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(context, title: "Enter plan details", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kWalletCard(context),
                height10,
                kCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kPlanCard(
                        context,
                        customerName: widget.masterdata.customerName,
                        providerImage: widget.masterdata.providerImage!,
                        providerName: widget.masterdata.providerName!,
                        phone: widget.masterdata.customerPhone,
                      ),
                      height20,
                      KTextfield.regular(
                        context,
                        controller: _amount,
                        label: "Enter recharge amount",
                        hintText: "Amount",
                        prefixText: "₹",
                        textSize: 25,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (val) {
                          if (val!.isEmpty)
                            return "Required!";
                          else if (int.parse(val) < 1)
                            return "Enter valid amount!";
                          return null;
                        },
                      ),
                      height10,
                      KButton.full(
                        onPressed: () {
                          if (_formKey.currentState!.validate())
                            navPush(
                                context,
                                Mobile_Checkout_UI(
                                  masterdata: widget.masterdata.copyWith(
                                    planAmount: _amount.text.trim(),
                                  ),
                                ));
                        },
                        label: "Recharge",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
