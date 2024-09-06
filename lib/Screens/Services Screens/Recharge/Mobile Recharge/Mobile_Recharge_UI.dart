// ignore_for_file: unused_result
import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Repository/recharge_repository.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Recharge_Plan_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ContactsUI.dart';

class Mobile_Recharge_UI extends ConsumerStatefulWidget {
  final Mobile_Recharge_Model masterdata;
  const Mobile_Recharge_UI({super.key, required this.masterdata});

  @override
  ConsumerState<Mobile_Recharge_UI> createState() =>
      _Mobile_Recharge_UIState(masterdata: masterdata);
}

class _Mobile_Recharge_UIState extends ConsumerState<Mobile_Recharge_UI> {
  final Mobile_Recharge_Model masterdata;
  _Mobile_Recharge_UIState({required this.masterdata});
  String _customerName = "";
  final _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String providerImage = "";
  String providerName = "";
  int providerId = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        providerId = widget.masterdata.providerId!;
        providerImage = widget.masterdata.providerImage!;
        providerName = widget.masterdata.providerName!;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync =
        ref.watch(rechargeHistoryFuture(widget.masterdata.service));
    return KScaffold(
      appBar: KAppBar(context,
          title: "${widget.masterdata.service} Recharge", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                providerImage.isNotEmpty
                    ? kPlanCard(
                        context,
                        providerImage: providerImage,
                        providerName: providerName,
                      )
                    : SizedBox(),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                          setState(() {
                            _customerName = contact["name"];
                            _phone.text = contact["phone"];
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
                    if (_formKey.currentState!.validate()) {
                      final data = masterdata.copyWith(
                        customerName: _customerName,
                        customerPhone: _phone.text.trim(),
                        providerId: providerId,
                        providerName: providerName,
                        providerImage: providerImage,
                      );

                      navPush(
                          context,
                          Recharge_Plan_UI(
                            recharge_data: null,
                            mobile_recharge_data: data,
                          )).then(
                        (value) => _customerName = "",
                      );
                    }
                  },
                  label: "Proceed",
                ),
                height20,
                kLabel("Recent contacts"),
                height15,
                historyAsync.when(
                  data: (data) => data.length > 0
                      ? ListView.separated(
                          separatorBuilder: (context, index) => height10,
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _historyTile(data[index]),
                        )
                      : kNoData(
                          title: "No recent recharges!",
                          subtitle: "Initiate with your first recharge!"),
                  error: (error, stackTrace) => kNoData(
                    title: "Some error occurred!",
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _historyTile(Map data) {
    return GestureDetector(
      onTap: () {
        _phone.text = data["consumerNo"];
        providerId = data["providerId"];
        providerName = data["providerName"];
        providerImage = data["image"];
        setState(() {});
      },
      child: Container(
        color: kCardColor,
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: CachedNetworkImage(
                imageUrl: data["image"],
                fit: BoxFit.contain,
              ),
            ),
            width20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data["providerName"]}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("${data["consumerNo"]}"),
                  height5,
                  Text(
                    "Last recharged ₹${data["amount"]} on ${kFormatDateInWords(data["date"])}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
