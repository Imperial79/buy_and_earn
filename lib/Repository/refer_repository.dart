import 'dart:convert';
import 'dart:developer';

import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myReferFuture = FutureProvider.family<List, String>(
  (ref, body) async {
    final res =
        await apiCallBack(path: "/refers/fetch", body: jsonDecode(body));

    if (!res.error) {
      return res.response;
    }
    return [];
  },
);

final referralSettingsFuture = FutureProvider<ResponseModel>(
  (ref) async {
    final res = await apiCallBack(
      path: "/settings/fetch-referral-settings",
      method: "GET",
    );

    return res;
  },
);
