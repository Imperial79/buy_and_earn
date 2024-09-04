// ignore_for_file: unused_result
import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/recharge_model.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recharge_UI extends ConsumerStatefulWidget {
  final Recharge_Model masterdata;
  const Recharge_UI({super.key, required this.masterdata});

  @override
  ConsumerState<Recharge_UI> createState() =>
      _Recharge_UIState(masterdata: masterdata);
}

class _Recharge_UIState extends ConsumerState<Recharge_UI> {
  final Recharge_Model masterdata;
  _Recharge_UIState({required this.masterdata});
  final _consumerNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String providerImage = "";
  String providerName = "";
  int providerId = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        providerId = masterdata.providerId!;
        providerImage = masterdata.providerImage!;
        providerName = masterdata.providerName!;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _consumerNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(rechargeHistoryFuture(masterdata.service));
    return KScaffold(
      appBar: KAppBar(context,
          title: "${masterdata.service} Recharge", showBack: true),
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
                Text("Enter ${masterdata.service} Consumer ID/Number"),
                height10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: KTextfield.regular(
                        context,
                        controller: _consumerNo,
                        textCapitalization: TextCapitalization.characters,
                        hintText: "Consumer ID/No",
                        validator: (val) {
                          if (val!.isEmpty) return "Required!";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                height10,
                KButton.full(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final data = masterdata.copyWith(
                        consumerNo: _consumerNo.text.trim(),
                        providerId: providerId,
                        providerName: providerName,
                        providerImage: providerImage,
                      );

                      navPush(
                          context,
                          Recharge_Plan_UI(
                            recharge_data: data,
                            mobile_recharge_data: null,
                          ));
                    }
                  },
                  label: "Proceed",
                ),
                height20,
                kLabel("Recent"),
                height15,
                historyAsync.when(
                  data: (data) => data.length > 0
                      ? ListView.separated(
                          separatorBuilder: (context, index) => height10,
                          itemCount: data.length,
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
        _consumerNo.text = data["consumerNo"];
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
