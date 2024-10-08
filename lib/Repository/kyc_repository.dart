import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kyc_repository = Provider(
  (ref) => KycRepository(),
);

final showKycReminder = StateProvider(
  (ref) => true,
);
final showProfileReminder = StateProvider(
  (ref) => true,
);

// final kycFuture = FutureProvider<Map?>(
//   (ref) async {
//     final res = await apiCallBack(path: "/kyc/fetch");
//     if (!res.error) {
//       return res.response;
//     }
//     return null;
//   },
// );

class KycRepository {
  Future<ResponseModel> fetchKycData({
    Map<String, dynamic> body = const {},
  }) async {
    final res = await apiCallBack(
      path: "/kyc/fetch",
    );
    return res;
  }

  Future<ResponseModel> uploadKycData({
    Map<String, dynamic> body = const {},
  }) async {
    final res = await apiCallBack(path: "/kyc/update", body: body);
    return res;
  }
}
