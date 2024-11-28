// ignore_for_file: unused_result

import 'dart:convert';

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/refer_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/Label.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

class ReferUI extends ConsumerStatefulWidget {
  const ReferUI({super.key});

  @override
  ConsumerState<ReferUI> createState() => _ReferUIState();
}

class _ReferUIState extends ConsumerState<ReferUI> {
  int pageNo = 0;
  int _selectedTier = 1;

  _refresh() async {
    ref.refresh(myReferFuture(jsonEncode({
      "pageNo": 0,
      "tier": _selectedTier,
    })).future);
    await ref.refresh(referralSettingsFuture.future);
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider);
    final referListData = ref.watch(myReferFuture(jsonEncode({
      "pageNo": pageNo,
      "tier": _selectedTier,
    })));

    final referSettings = ref.watch(referralSettingsFuture);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(navigationProvider.notifier).state = 0;
      },
      child: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: KScaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.all(kPadding).copyWith(top: 0, bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kWalletCard(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer?.name.toLowerCase() ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Text(
                        "Level ${customer!.level}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                  referSettings.when(
                    data: (data) {
                      return parseToDouble(data.response['referralAmount']) > 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: kCard(
                                color: kColor(context).secondaryContainer,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label(
                                      "Get ${kCurrencyFormat("${data.response['referralAmount']}", decimalDigit: 0)} bonus on referal *",
                                    ).title,
                                    height10,
                                    kCard(
                                      radius: 8,
                                      padding: const EdgeInsets.all(8.0),
                                      color: kColor(context).surface,
                                      child: Label(
                                        "Note: Valid for only complete registrations and id activation during offer period",
                                      ).subtitle,
                                    ),
                                    height15,
                                    Row(
                                      children: [
                                        kWidgetPill(
                                          context,
                                          backgroundColor:
                                              kColor(context).primary,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                customer.referCode,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        width10,
                                        IconButton.filled(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: customer.referCode));

                                            KSnackbar(context,
                                                content:
                                                    "Refer code copied to clipboard!");
                                          },
                                          visualDensity: VisualDensity.compact,
                                          icon: const Icon(
                                            Icons.copy,
                                            size: 15,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton.filled(
                                          onPressed: () async {
                                            await FlutterShare.share(
                                              title: "Download now!",
                                              text:
                                                  "Use my refer code for signing up in Buy N Earn. Let's earn together",
                                              linkUrl:
                                                  "https://play.google.com/store/apps/details?id=com.buynearn.shop.customer&hl=en",
                                            );
                                          },
                                          visualDensity: VisualDensity.compact,
                                          icon: Row(
                                            children: [
                                              const Icon(
                                                Icons.share,
                                                size: 15,
                                              ),
                                              width5,
                                              const Text(
                                                "Invite",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                    error: (error, stackTrace) => const SizedBox(),
                    loading: () => const SizedBox(),
                  ),
                  height20,
                  Label("Distribution").regular,
                  height10,
                  referSettings.when(
                    data: (data) => _distributionChart(data),
                    error: (error, stackTrace) => const SizedBox(),
                    loading: () => const SizedBox(),
                  ),
                  height20,
                  Label("My Referals").regular,
                  height10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(6, (index) => _levelBtn(index + 1)),
                    ),
                  ),
                  height15,
                  referListData.when(
                    data: (data) => Column(
                      children: [
                        data.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (context, index) => height10,
                                itemCount: data.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Card(
                                  color: Light.card,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data[index]['dp'] == null
                                            ? CircleAvatar(
                                                child: Text(
                                                  data[index]['name'][0]
                                                      .toUpperCase(),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  data[index]['dp'],
                                                ),
                                              ),
                                        width10,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index]['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                "+91 ${data[index]['phone']}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "Joined On: ${kFormatDate(data[index]["date"])}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        width10,
                                        Text(
                                          kCurrencyFormat(
                                              "${data[index]["firstPurchase"]}"),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : kNoData(
                                title: "No Data!",
                                subtitle: "Refer more people!"),
                        height20,
                        kPagination(
                          pageNo: pageNo,
                          onDecrement: () {
                            if (pageNo > 0) {
                              setState(() {
                                pageNo -= 1;
                              });
                            }
                          },
                          onIncrement: () {
                            setState(() {
                              pageNo += 1;
                            });
                          },
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _distributionChart(ResponseModel data) {
    return Center(
      child: kCard(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            decoration: BoxDecoration(
              color: Light.card,
              borderRadius: kRadius(10),
            ),
            columns: [
              DataColumn(
                label: Label("Level/Tier").regular,
              ),
              DataColumn(
                label: Label("Commission").regular,
              ),
              DataColumn(
                label: Label("Direct Refers").regular,
              ),
            ],
            rows: List.generate(data.response['charts'].length, (index) {
              final item = data.response['charts'][index];
              return DataRow(
                cells: [
                  DataCell(
                    Center(
                      child:
                          Label("${item['level']}", fontWeight: FontWeight.w700)
                              .regular,
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        "${item['commission']}%",
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        "${item['threshold']}",
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _levelBtn(index) {
    bool isActive = _selectedTier == index;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ChoiceChip(
        label: Text(
          "Tier $index",
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        onSelected: (value) {
          setState(() {
            pageNo = 0;
            _selectedTier = index;
          });
        },
        selected: isActive,
        selectedColor: kColor(context).primary,
        checkmarkColor: Colors.white,
      ),
    );
  }
}
