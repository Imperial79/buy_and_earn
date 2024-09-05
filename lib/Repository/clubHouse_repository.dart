import 'package:buy_and_earn/Models/response_model.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clubHouseRepository = Provider((ref) => ClubHouse());

class ClubHouse {
  Future<ResponseModel> buyMembership() async {
    final res = await apiCallBack(path: "path");

    return res;
  }
}
