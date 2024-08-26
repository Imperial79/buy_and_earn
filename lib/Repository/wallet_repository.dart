import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletFuture = FutureProvider.autoDispose<Map?>((ref) async {
  final res = await apiCallBack(path: "/wallet/fetch", method: "GET");
  ref.keepAlive();
  if (!res.error) {
    // return WalletModel.fromMap(res.response);
    return res.response;
  }
  return null;
});
