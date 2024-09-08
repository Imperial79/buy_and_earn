import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isModalShown = StateProvider(
  (ref) => false,
);

final clubHouseRepository = Provider((ref) => ClubHouse());

final clubHouseFuture = FutureProvider.autoDispose<Map?>(
  (ref) async {
    final res = await apiCallBack(path: "/club-house/fetch", method: "GET");
    if (!res.error) {
      return res.response;
    }
    return null;
  },
);

class ClubHouse {
  Future<ResponseModel> fetch(String tpin) async {
    final res = await apiCallBack(path: "/club-house/fetch", method: "GET");
    return res;
  }

  Future<ResponseModel> buyMembership(String tpin) async {
    final res = await apiCallBack(
      path: "/club-house/apply",
      body: {"tpin": tpin},
    );
    return res;
  }
}
