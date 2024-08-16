import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Components/constants.dart';
import '../Components/widgets.dart';
import '../Repository/mobile_recharge_repository.dart';
import '../Utils/Common Widgets/kButton.dart';
import '../Utils/Common Widgets/kTextfield.dart';
import '../Utils/commons.dart';

class ContactsUI extends ConsumerStatefulWidget {
  const ContactsUI({super.key});

  @override
  ConsumerState<ContactsUI> createState() => _ContactsUIState();
}

class _ContactsUIState extends ConsumerState<ContactsUI> {
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
      appBar: KAppBar(
        context,
        title: "Contacts",
        showBack: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            children: [
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
              Expanded(
                child: hasPermission
                    ? contactsData.when(
                        data: (data) => ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            if (kCompare(
                                    searchKey.text, data[index].displayName) ||
                                kCompare(searchKey.text,
                                    data[index].phones[0].normalizedNumber)) {
                              return _contactCard(data[index]);
                            }
                            return SizedBox();
                          },
                        ),
                        error: (error, stackTrace) =>
                            Text("Cannot load contacts!"),
                        loading: () =>
                            Center(child: CircularProgressIndicator.adaptive()),
                      )
                    : kNoData(
                        title: "No Contacts!",
                        subtitle:
                            "Please provider contacts permission to view your contacts.",
                        action: KButton.pill(
                          onPressed: () async {
                            final res =
                                await FlutterContacts.requestPermission();
                            ref.read(hasContactPermission.notifier).state = res;
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
            ],
          ),
        ),
      ),
    );
  }

  ListTile _contactCard(Contact data) {
    return ListTile(
      onTap: () {
        Navigator.pop(context, {
          "phone": data.phones[0].normalizedNumber,
        });
      },
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
