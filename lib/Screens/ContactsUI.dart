import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  List<Contact> _contacts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => _fetchContacts());
  }

  _fetchContacts() async {
    setState(() {
      isLoading = true;
    });
    final res = await ref.watch(mobile_recharge_repository).fetchContacts();

    setState(() {
      _contacts = res;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    searchKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission = ref.watch(hasContactPermission);

    return KScaffold(
      appBar: KAppBar(context,
          title: "Contacts", showBack: true, isLoading: isLoading),
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
                    ? _contacts.length > 0
                        ? ListView.builder(
                            itemCount: _contacts.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              if (_contacts[index].phones.isNotEmpty) {
                                if (kCompare(searchKey.text,
                                        _contacts[index].displayName) ||
                                    kCompare(
                                        searchKey.text,
                                        _contacts[index]
                                            .phones[0]
                                            .normalizedNumber)) {
                                  return _contactCard(_contacts[index]);
                                }
                                return SizedBox();
                              }
                              return SizedBox();
                            },
                          )
                        : kNoData(
                            image: "assets/images/contacts.svg",
                            title: "No Contacts!",
                            subtitle: "Add contacts in your phone to view!")
                    : kNoData(
                        image: "assets/images/contacts.svg",
                        title: "Permission Required!",
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
          "name": data.displayName,
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
