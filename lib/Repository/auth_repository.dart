import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Models/user_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final auth = FutureProvider((ref) async {
  final res = await apiCallBack(path: "/users/auth", method: "GET");

  if (!res.error) {
    ref.read(userProvider.notifier).state = UserModel.fromMap(res.response);
  } else {
    ref.read(userProvider.notifier).state = null;
  }
});

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  Future<ResponseModel> fetchReferrerData(Map<String, dynamic> body) async {
    final res = await apiCallBack(
        path: "/users/referrer-data", method: "POST", body: body);

    return res;
  }

  Future<ResponseModel> sendOtp(Map<String, dynamic> body) async {
    final res = await apiCallBack(
        path: "/sms-service/send-otp", method: "POST", body: body);

    return res;
  }

  Future<ResponseModel> register(Map<String, dynamic> body) async {
    final res =
        await apiCallBack(path: "/users/register", method: "POST", body: body);

    return res;
  }

  Future<ResponseModel> logout(Map<String, dynamic> body) async {
    final res =
        await apiCallBack(path: "/users/logout", method: "GET", body: body);

    return res;
  }
}
