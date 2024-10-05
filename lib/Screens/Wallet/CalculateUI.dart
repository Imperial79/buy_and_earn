import 'dart:convert';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CalculateUI extends StatefulWidget {
  const CalculateUI({super.key});

  @override
  State<CalculateUI> createState() => _CalculateUIState();
}

class _CalculateUIState extends State<CalculateUI> {
  final mrp = TextEditingController();
  final profitMargin = TextEditingController();
  final eligibleWBCustomers = TextEditingController();
  String resp = "";

  @override
  void dispose() {
    mrp.dispose();
    profitMargin.dispose();
    eligibleWBCustomers.dispose();
    super.dispose();
  }

  Future calculateAPI() async {
    final dio = Dio();

    final formData = FormData.fromMap({
      "mrp": mrp.text,
      "profitMargin": profitMargin.text,
      "eligibleWBCustomers": eligibleWBCustomers.text
    });

    final response = await dio.post(
      baseUrl + "/cal/in",
      data: formData,
    );

    setState(() {
      resp = JsonEncoder.withIndent('  ').convert(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculation"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  KTextfield(
                    controller: mrp,
                    hintText: "Ex: 233",
                    label: "MRP",
                    keyboardType: TextInputType.number,
                  ).regular,
                  height10,
                  KTextfield(
                    controller: profitMargin,
                    hintText: "Ex: 3 or 6",
                    label: "Profit Margin (%)",
                    keyboardType: TextInputType.number,
                  ).regular,
                  height10,
                  KTextfield(
                    controller: eligibleWBCustomers,
                    hintText: "Ex: 1 or 4",
                    label: "Working Bonus Eligible Customers",
                    keyboardType: TextInputType.number,
                  ).regular,
                  height10,
                  KButton(
                    onPressed: () {
                      calculateAPI();
                    },
                    label: "Calculate Bonus",
                  ).full,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(),
                  ),
                  Text(
                    "${resp}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
