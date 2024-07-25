import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionDetailUI extends StatefulWidget {
  const TransactionDetailUI({super.key});

  @override
  State<TransactionDetailUI> createState() => _TransactionDetailUIState();
}

class _TransactionDetailUIState extends State<TransactionDetailUI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusCard(),
              height20,
              kLabel("Mobile Recharge"),
              height20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: SvgPicture.asset(
                      kIconMap["mobile"]!,
                    ),
                  ),
                  width10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jio Prepaid",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Text("+91 9093086276"),
                      ],
                    ),
                  ),
                  Text(
                    "₹181",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
              height20,
              Text(
                "Transaction Details",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Divider(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recharge Amount"),
                  Text("₹179"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GST"),
                  Text("₹2"),
                ],
              ),
              Divider(
                height: 30,
              ),
              Text(
                "Transaction ID",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "HSAGDSGDSD6S7D87AS6D",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _statusCard() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: kRadius(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outlined,
            color: Colors.white,
          ),
          width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction Successful",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "12 Jan 2024, 10:30 AM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
