import 'dart:convert';

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
