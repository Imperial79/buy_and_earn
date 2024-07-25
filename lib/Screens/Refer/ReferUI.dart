import 'dart:convert';

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/refer_repository.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferUI extends ConsumerStatefulWidget {
  const ReferUI({super.key});

  @override
  ConsumerState<ReferUI> createState() => _ReferUIState();
}

class _ReferUIState extends ConsumerState<ReferUI> {
  int pageNo = 0;
  int _selectedTier = 1;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final referListData = ref.watch(myReferFuture(jsonEncode({
      "pageNo": pageNo,
      "tier": _selectedTier,
    })));

    return RefreshIndicator(
      onRefresh: () => ref.refresh(myReferFuture(jsonEncode({
        "pageNo": 0,
        "tier": _selectedTier,
      })).future),
      child: KScaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kWalletCard(context),
                height15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name.toLowerCase() ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          Text(
                            "Level ${user!.level}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Earnings",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text(
                          "₹ 500.00",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                height20,
                Card(
                  color: kColor(context).tertiary,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get ₹10 bonus on referal*",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          height10,
                          Card(
                            color: kColor(context).onTertiaryFixedVariant,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Note: Valid for only complete registrations during offer period",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          height15,
                          Row(
                            children: [
                              kWidgetPill(
                                context,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${user.referCode}",
                                        style: TextStyle(
                                          color: kColor(context).tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              width10,
                              IconButton.filledTonal(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: "${user.referCode}"));

                                  KSnackbar(context,
                                      content:
                                          "Refer code copied to clipboard!");
                                },
                                visualDensity: VisualDensity.compact,
                                icon: Icon(
                                  Icons.copy,
                                  color: kColor(context).tertiary,
                                  size: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                height20,
                kLabel("Distribution"),
                height15,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    decoration: BoxDecoration(
                      color: kCardColor,
                      borderRadius: kRadius(10),
                    ),
                    columns: [
                      DataColumn(
                        label: Text("Level/Tier"),
                      ),
                      DataColumn(
                        label: Text("Commission"),
                      ),
                      DataColumn(
                        label: Text("Direct Refers"),
                      ),
                    ],
                    rows: List.generate(
                      6,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text("Lvl. ${index + 1}"),
                          ),
                          DataCell(
                            Text("12%"),
                          ),
                          DataCell(
                            Text("10"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                height20,
                kLabel("My Referals"),
                height15,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) => _levelBtn(index + 1)),
                  ),
                ),
                height15,
                referListData.when(
                  data: (data) => ListView.separated(
                    separatorBuilder: (context, index) => height10,
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                      color: kCardColor,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Text(
                                data[index]['name'][0].toUpperCase(),
                              ),
                            ),
                            width10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "+91 ${data[index]['phone']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Joined On: ${kFormatDate(data[index]["date"])}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            width10,
                            Text(
                              "₹100",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => SizedBox(),
                  loading: () => CircularProgressIndicator(),
                ),
                kHeight(100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _levelBtn(index) {
    bool isActive = _selectedTier == index;
    return MaterialButton(
      onPressed: () {
        setState(() {
          _selectedTier = index;
        });
      },
      color: isActive ? kColor(context).primaryContainer : Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: kRadius(10)),
      child: Text("Tier $index"),
    );
  }
}
