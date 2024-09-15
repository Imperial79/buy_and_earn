import 'dart:developer';

import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselFuture = FutureProvider.autoDispose<List>(
  (ref) async {
    final res = await apiCallBack(path: "/carousels/fetch");
    log("$res");
    ref.keepAlive();
    if (!res.error) {
      return res.response;
    }
    return [];
  },
);
