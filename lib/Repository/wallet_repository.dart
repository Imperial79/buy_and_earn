import 'dart:convert';

import 'package:buy_and_earn/Models/transactions_model.dart';
import 'package:buy_and_earn/Models/wallet_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionList = StateProvider<List<Transactions_Model>>((ref) => []);

final walletFuture = FutureProvider.autoDispose<WalletModel?>((ref) async {
  final res = await apiCallBack(path: "/wallet/fetch", method: "GET");
  ref.keepAlive();
  if (!res.error) {
    return WalletModel.fromMap(res.response);
    // return res.response;
  }
  return null;
});

final transactionFuture =
    FutureProvider.autoDispose.family<List<Transactions_Model>, String>(
  (ref, data) async {
    final body = jsonDecode(data);
    int pageNo = body["pageNo"];

    final res = await apiCallBack(
      path: "/wallet/passbook",
      body: body,
    );
    if (!res.error) {
      final dataList = res.response as List;

      if (pageNo == 0) {
        ref.read(transactionList.notifier).state = [];
      }
      ref.read(transactionList.notifier).state.addAll(
            dataList.map(
              (e) => Transactions_Model.fromMap(e),
            ),
          );
    }

    return ref.read(transactionList);
  },
);
