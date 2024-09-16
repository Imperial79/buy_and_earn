import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kyc_repository = Provider(
  (ref) => KycRepository(),
);

final showKycBanner = StateProvider(
  (ref) => true,
);

final kycFuture = FutureProvider(
  (ref) async {
    final res = await apiCallBack(path: "/kyc/fetch");
    if (!res.error) {
      return res.response;
    }
    return null;
  },
);

class KycRepository {
  Future<ResponseModel> uploadKycData({
    Map<String, dynamic> body = const {},
  }) async {
    final res = await apiCallBack(path: "/kyc/update", body: body);
    return res;
  }
}
