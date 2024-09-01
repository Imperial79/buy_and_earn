import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
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

final rechargeHistoryFuture = FutureProvider.autoDispose.family<List, String>(
  (ref, service) async {
    final res = await apiCallBack(
      path: "/recharge-providers/${service.toLowerCase()}/history",
      method: "GET",
    );

    if (!res.error) {
      return res.response;
    }
    return [];
  },
);

final providersListFuture = FutureProvider.autoDispose.family<List, String>(
  (ref, service) async {
    final res = await apiCallBack(
      path: "/recharge-providers/fetch",
      method: "POST",
      body: {
        "service": service,
      },
    );

    ref.keepAlive();

    if (!res.error) {
      return res.response as List;
    }
    return [];
  },
);

final mobile_recharge_repository = Provider(
  (ref) => MobileRechargeRepository(),
);

class MobileRechargeRepository {
  Future<ResponseModel> rechargeMobile({
    required String providerId,
    required String consumerNo,
    required String tpin,
    required String rechargeAmount,
  }) async {
    final res = await apiCallBack(
      path: "/recharge-providers/prepaid/recharge",
      body: {
        "providerId": providerId,
        "consumerNo": consumerNo,
        "tpin": tpin,
        "rechargeAmount": rechargeAmount,
      },
    );

    return res;
  }

  Future<ResponseModel> recharge({
    required String providerId,
    required String consumerNo,
    required String tpin,
    required String rechargeAmount,
  }) async {
    print(
      {
        "providerId": providerId,
        "consumerNo": consumerNo,
        "tpin": tpin,
        "rechargeAmount": rechargeAmount,
      },
    );
    final res = await apiCallBack(
      path: "/recharge-providers/dth/recharge",
      body: {
        "providerId": providerId,
        "consumerNo": consumerNo,
        "tpin": tpin,
        "rechargeAmount": rechargeAmount,
      },
    );

    return res;
  }

  Future<List<Contact>> fetchContacts() async {
    List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);

    // return contacts.where((contact) {
    //   return contact.phones.isNotEmpty;
    // }).toList();
    return contacts;
  }
}
