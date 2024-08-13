// ignore_for_file: unused_result

import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/mobile_recharge_repository.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Plan_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mobile_Recharge_UI extends ConsumerStatefulWidget {
  const Mobile_Recharge_UI({super.key});

  @override
  ConsumerState<Mobile_Recharge_UI> createState() => _Mobile_Recharge_UIState();
}

class _Mobile_Recharge_UIState extends ConsumerState<Mobile_Recharge_UI> {
  final searchKey = TextEditingController();

  @override
  void dispose() {
    searchKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission = ref.watch(hasContactPermission);

    var contactsData = ref.watch(contactsFuture);
    return KScaffold(
      appBar: KAppBar(context, title: "Mobile Recharge", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kCard(
                child: Row(
                  children: [
                    CircleAvatar(),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Airtel",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Pan India",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              height20,
              Text("Enter or Select your phone number"),
              height10,
              KTextfield.regular(
                context,
                prefixText: "+91",
                keyboardType: TextInputType.phone,
                hintText: "Enter phone number here",
                maxLength: 10,
              ),
              height10,
              KButton.full(
                  onPressed: () {
                    navPush(context, Plan_UI());
                  },
                  label: "Proceed"),
              height15,
              kCard(
                child: SizedBox(
                  width: double.maxFinite,
                  child: hasPermission
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: kLabel("All Contacts")),
                                IconButton(
                                  onPressed: () async {
                                    await ref.refresh(contactsFuture.future);
                                  },
                                  icon: contactsData.isRefreshing
                                      ? CircularProgressIndicator()
                                      : Icon(
                                          Icons.refresh,
                                        ),
                                ),
                              ],
                            ),
                            height10,
                            KTextfield.regular(
                              context,
                              controller: searchKey,
                              hintText: "Search name or phone",
                              prefix: Icon(
                                Icons.search,
                                size: 25,
                              ),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                            height10,
                            contactsData.when(
                              data: (data) => ListView.builder(
                                itemCount: data.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (kCompare(searchKey.text,
                                          data[index].displayName) ||
                                      kCompare(
                                          searchKey.text,
                                          data[index]
                                              .phones[0]
                                              .normalizedNumber)) {
                                    return _contactCard(data[index]);
                                  }
                                  return SizedBox();
                                },
                              ),
                              error: (error, stackTrace) =>
                                  Text("Cannot load contacts!"),
                              loading: () => Center(
                                  child: CircularProgressIndicator.adaptive()),
                            )
                          ],
                        )
                      : kNoData(
                          title: "No Contacts!",
                          subtitle:
                              "Please provider contacts permission to view your contacts.",
                          action: KButton.pill(
                            onPressed: () async {
                              final res =
                                  await FlutterContacts.requestPermission();
                              ref.read(hasContactPermission.notifier).state =
                                  res;
                              if (!res) {
                                KSnackbar(context,
                                    content:
                                        "Enable contacts permission from settings!",
                                    isDanger: true);
                              }
                            },
                            label: "Allow",
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _contactCard(Contact data) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: data.photo != null ? MemoryImage(data.photo!) : null,
        child: Visibility(
          visible: data.photo == null,
          child: Text(
            data.displayName[0],
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
      title: Text(
        data.displayName,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text("${data.phones[0].normalizedNumber}"),
    );
  }
}
