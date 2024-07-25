import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';

class TransactionsUI extends StatefulWidget {
  const TransactionsUI({super.key});

  @override
  State<TransactionsUI> createState() => _TransactionsUIState();
}

class _TransactionsUIState extends State<TransactionsUI> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kHeading("Transactions"),
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        isDismissible: false,
                        isScrollControlled: true,
                        useSafeArea: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        builder: (context) => _filterModal(),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: kRadius(10),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    child: Row(
                      children: [
                        Text("Filters"),
                        width5,
                        Icon(
                          Icons.filter_alt,
                          size: 17,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              height20,
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        kRecentHistoryCard(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterModal() {
    return StatefulBuilder(
      builder: (context, setState) => SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                  kHeading("filters"),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text("Clear All"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _filterCategoryBtn(context, label: "Status"),
                            _filterCategoryBtn(context, label: "Status"),
                            _filterCategoryBtn(context, label: "Status"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            20,
                            (index) => MaterialButton(
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  Text("data")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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

  MaterialButton _filterCategoryBtn(
    BuildContext context, {
    required String label,
  }) {
    return MaterialButton(
      onPressed: () {},
      color: kColor(context).primaryContainer,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: kRadius(10),
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
