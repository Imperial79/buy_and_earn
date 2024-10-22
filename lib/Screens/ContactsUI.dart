import 'dart:developer';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Components/constants.dart';
import '../Components/widgets.dart';
import '../Repository/recharge_repository.dart';
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

  Future<void> _fetchContacts() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (await Permission.contacts.request() == PermissionStatus.granted) {
        ref.read(hasContactPermission.notifier).state = true;
        final res = await ref.watch(mobile_recharge_repository).fetchContacts();
        _contacts = res;
      } else {
        ref.read(hasContactPermission.notifier).state = false;
      }
    } catch (e) {
      log("$e");
      KSnackbar(context, content: "Something went wrong!", isDanger: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission = ref.watch(hasContactPermission);
    return RefreshIndicator(
      onRefresh: () async {
        await _fetchContacts();
      },
      child: KScaffold(
        appBar: KAppBar(context,
            title: "Contacts", showBack: true, isLoading: isLoading),
        body: SafeArea(
          child: Column(
            children: [
              height10,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding),
                child: KTextfield(
                  controller: searchKey,
                  hintText: "Search name or phone",
                  prefix: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                ).regular,
              ),
              // height10,
              Expanded(
                child: hasPermission
                    ? _contacts.isNotEmpty
                        ? ListView.builder(
                            itemCount: _contacts.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(kPadding),
                            itemBuilder: (context, index) {
                              if (_contacts[index].phones.isNotEmpty) {
                                if (kCompare(searchKey.text,
                                        _contacts[index].displayName) ||
                                    kCompare(
                                        searchKey.text,
                                        _contacts[index]
                                            .phones[0]
                                            .normalizedNumber)) {
                                  return _contactTile(_contacts[index]);
                                }
                                return const SizedBox();
                              }
                              return null;
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
                        action: KButton(
                          onPressed: () async {
                            final res = await Permission.contacts.request();
                            ref.read(hasContactPermission.notifier).state =
                                res == PermissionStatus.granted;
                            if (res == PermissionStatus.denied) {
                              KSnackbar(
                                context,
                                content:
                                    "Enable contacts permission from settings!",
                                isDanger: true,
                                action: SnackBarAction(
                                  textColor: Colors.white,
                                  label: "Open",
                                  onPressed: () async {
                                    final res = await openAppSettings();
                                    if (res) {
                                      _fetchContacts();
                                    }
                                  },
                                ),
                              );
                            }
                          },
                          label: "Allow",
                        ).pill,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactTile(Contact data) {
    String phone = sanitizeContact(data.phones[0].normalizedNumber);
    return InkWell(
      onTap: () {
        Navigator.pop(context, {
          "name": data.displayName,
          "phone": phone,
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(data.displayName[0].toUpperCase()),
            ),
            width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.displayName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  height5,
                  Text("+91 $phone"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ListTile _contactCard(Contact data) {
  //   return ListTile(
  // onTap: () {
  //   Navigator.pop(context, {
  //     "name": data.displayName,
  //     "phone": data.phones[0].normalizedNumber,
  //   });
  // },
  //     contentPadding: EdgeInsets.zero,
  //     leading: CircleAvatar(
  //       backgroundImage: data.photo != null ? MemoryImage(data.photo!) : null,
  //       child: Visibility(
  //         visible: data.photo == null,
  //         child: Text(
  //           data.displayName[0],
  //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
  //         ),
  //       ),
  //     ),
  //     title: Text(
  //       data.displayName,
  //       style: TextStyle(fontWeight: FontWeight.w500),
  //     ),
  //     subtitle: Text("${data.phones[0].normalizedNumber}"),
  //   );
  // }
}
