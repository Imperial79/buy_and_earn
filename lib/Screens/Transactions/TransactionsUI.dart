// ignore_for_file: unused_result

import 'dart:convert';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';

import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsUI extends ConsumerStatefulWidget {
  const TransactionsUI({super.key});

  @override
  ConsumerState<TransactionsUI> createState() => _TransactionsUIState();
}

class _TransactionsUIState extends ConsumerState<TransactionsUI> {
  int pageNo = 0;

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(transactionFuture(jsonEncode({
      "pageNo": pageNo,
      "fromDate": "",
      "toDate": "",
      "type": "All",
    })));

    final transactionData = ref.watch(transactionList);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(navigationProvider.notifier).state = 0;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          if (pageNo != 0) {
            setState(() {
              pageNo = 0;
            });
          } else {
            await ref.refresh(transactionFuture(jsonEncode({
              "pageNo": pageNo,
              "fromDate": "",
              "toDate": "",
              "type": "All",
            })).future);
          }
        },
        child: KScaffold(
          appBar: KAppBar(
            context,
            showBack: false,
            title: "Transactions",
            // actions: [
            //   // MaterialButton(
            //   //   onPressed: () {
            //   //     showModalBottomSheet(
            //   //       context: context,
            //   //       enableDrag: false,
            //   //       isDismissible: false,
            //   //       isScrollControlled: true,
            //   //       useSafeArea: true,
            //   //       elevation: 0,
            //   //       backgroundColor: Colors.white,
            //   //       builder: (context) => _filterModal(),
            //   //     );
            //   //   },
            //   //   shape: RoundedRectangleBorder(
            //   //     borderRadius: kRadius(10),
            //   //     side: BorderSide(
            //   //       color: Colors.black,
            //   //     ),
            //   //   ),
            //   //   visualDensity: VisualDensity.compact,
            //   //   child: Row(
            //   //     children: [
            //   //       Text("Filters"),
            //   //       width5,
            //   //       Icon(
            //   //         Icons.filter_alt,
            //   //         size: 17,
            //   //       ),
            //   //     ],
            //   //   ),
            //   // ),
            //   width10,
            // ],
            isLoading: asyncData.isLoading,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kPadding).copyWith(bottom: 120),
              child: !asyncData.hasError
                  ? transactionData.isNotEmpty
                      ? Column(
                          children: [
                            ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                height: 30,
                                color: Colors.grey.shade300,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: transactionData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  kRecentHistoryCard(
                                context,
                                transactionData[index],
                              ),
                            ),
                            height15,
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    pageNo += 1;
                                  });
                                },
                                child: const Text("View More"))
                          ],
                        )
                      : kNoData(
                          title: "No transactions!",
                          subtitle: "Initiate with your first recharge!")
                  : kNoData(title: "Some Error occurred!"),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _filterModal() {
  //   return StatefulBuilder(
  //     builder: (context, setState) => SafeArea(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Row(
  //               children: [
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   icon: const Icon(Icons.close),
  //                 ),
  //                 kHeading("filters"),
  //                 const Spacer(),
  //                 TextButton(
  //                   onPressed: () {},
  //                   child: const Text("Clear All"),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     padding: const EdgeInsets.symmetric(horizontal: 5),
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         children: [
  //                           _filterCategoryBtn(context, label: "Status"),
  //                           _filterCategoryBtn(context, label: "Status"),
  //                           _filterCategoryBtn(context, label: "Status"),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         children: List.generate(
  //                           20,
  //                           (index) => MaterialButton(
  //                             onPressed: () {},
  //                             padding: const EdgeInsets.symmetric(
  //                                 horizontal: 10, vertical: 3),
  //                             child: Row(
  //                               children: [
  //                                 Checkbox(
  //                                   value: false,
  //                                   onChanged: (value) {},
  //                                 ),
  //                                 const Text("data")
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // MaterialButton _filterCategoryBtn(
  //   BuildContext context, {
  //   required String label,
  // }) {
  //   return MaterialButton(
  //     onPressed: () {},
  //     color: kColor(context).primaryContainer,
  //     elevation: 0,
  //     highlightElevation: 0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: kRadius(10),
  //     ),
  //     child: SizedBox(
  //       width: double.maxFinite,
  //       child: Text(
  //         label,
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }
}
