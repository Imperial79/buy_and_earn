import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Models/user_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
  Future<ResponseModel> updateDp(XFile image) async {
    final res = await apiCallBack(
        path: "/users/update-dp",
        method: "POST",
        body: {"mediaFile": await MultipartFile.fromFile(image.path)});

    return res;
  }

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

  Future<ResponseModel> login(Map<String, dynamic> body) async {
    final res =
        await apiCallBack(path: "/users/login", method: "POST", body: body);

    return res;
  }

  Future<ResponseModel> changePins(Map<String, dynamic> body) async {
    final res = await apiCallBack(
        path: "/users/change-pins", method: "POST", body: body);

    return res;
  }
}
