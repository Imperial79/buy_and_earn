import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Models/recharge_model.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Recharge_Checkout_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recharge_Plan_UI extends ConsumerStatefulWidget {
  final Mobile_Recharge_Model? mobile_recharge_data;
  final Recharge_Model? recharge_data;
  const Recharge_Plan_UI({
    super.key,
    required this.recharge_data,
    required this.mobile_recharge_data,
  });

  @override
  ConsumerState<Recharge_Plan_UI> createState() => _Mobile_Plan_UIState();
}

class _Mobile_Plan_UIState extends ConsumerState<Recharge_Plan_UI> {
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
      appBar: KAppBar(context, title: "plan details", showBack: true),
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
                      widget.mobile_recharge_data != null
                          ? kPlanCard(
                              context,
                              customerName:
                                  widget.mobile_recharge_data!.customerName,
                              providerImage:
                                  widget.mobile_recharge_data!.providerImage!,
                              providerName:
                                  widget.mobile_recharge_data!.providerName!,
                              phone: "+91 " +
                                  widget.mobile_recharge_data!.customerPhone!,
                            )
                          : kPlanCard(
                              context,
                              providerImage:
                                  widget.recharge_data!.providerImage!,
                              providerName: widget.recharge_data!.providerName!,
                              phone: widget.recharge_data!.consumerNo,
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
                          if (_formKey.currentState!.validate()) {
                            if (widget.mobile_recharge_data != null) {
                              navPush(
                                  context,
                                  Recharge_Checkout_UI(
                                    mobile_recharge_data:
                                        widget.mobile_recharge_data!.copyWith(
                                      planAmount: _amount.text.trim(),
                                    ),
                                  ));
                            } else {
                              navPush(
                                  context,
                                  Recharge_Checkout_UI(
                                    recharge_data:
                                        widget.recharge_data!.copyWith(
                                      planAmount: _amount.text.trim(),
                                    ),
                                  ));
                            }
                          }
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
