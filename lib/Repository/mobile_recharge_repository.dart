import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasContactPermission = StateProvider((ref) => false);

final contactPermissionFuture = FutureProvider(
  (ref) async {
    if (await FlutterContacts.requestPermission()) {
      ref.read(hasContactPermission.notifier).state = true;
    } else {
      ref.read(hasContactPermission.notifier).state = false;
    }
  },
);

final contactsFuture = FutureProvider.autoDispose<List<Contact>>(
  (ref) async {
    List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);

    ref.keepAlive();
    return contacts.where((contact) {
      return contact.phones.isNotEmpty;
    }).toList();
  },
);
