import 'dart:convert';
import 'package:buy_and_earn/Utils/commons.dart';

class CustomerModel {
  int id = 0;
  String? dp;
  String name = "";
  String phone = "";
  String? email;
  String state = "";
  String city = "";
  String pinCode = "";
  String referCode = "";
  int level = 0;
  String firstService = "N";
  String referrerCode = "";
  String? fcmToken;
  String status = "Pending";
  String lastLogin = "";
  String date = "";
  double idActiveAmount = 0;
  double idActiveMinThreshold = 0;
  bool isMember = false;
  String kycStatus = "";
  CustomerModel({
    required this.id,
    this.dp,
    required this.name,
    required this.phone,
    this.email,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.referCode,
    required this.level,
    required this.firstService,
    required this.referrerCode,
    this.fcmToken,
    required this.status,
    required this.lastLogin,
    required this.date,
    required this.idActiveAmount,
    required this.idActiveMinThreshold,
    required this.isMember,
    required this.kycStatus,
  });

  CustomerModel copyWith({
    int? id,
    String? dp,
    String? name,
    String? phone,
    String? email,
    String? state,
    String? city,
    String? pinCode,
    String? referCode,
    int? level,
    String? firstService,
    String? referrerCode,
    String? fcmToken,
    String? status,
    String? lastLogin,
    String? date,
    double? idActiveAmount,
    double? idActiveMinThreshold,
    bool? isMember,
    String? kycStatus,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      dp: dp ?? this.dp,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      referCode: referCode ?? this.referCode,
      level: level ?? this.level,
      firstService: firstService ?? this.firstService,
      referrerCode: referrerCode ?? this.referrerCode,
      fcmToken: fcmToken ?? this.fcmToken,
      status: status ?? this.status,
      lastLogin: lastLogin ?? this.lastLogin,
      date: date ?? this.date,
      idActiveAmount: idActiveAmount ?? this.idActiveAmount,
      idActiveMinThreshold: idActiveMinThreshold ?? this.idActiveMinThreshold,
      isMember: isMember ?? this.isMember,
      kycStatus: kycStatus ?? this.kycStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dp': dp,
      'name': name,
      'phone': phone,
      'email': email,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'referCode': referCode,
      'level': level,
      'firstService': firstService,
      'referrerCode': referrerCode,
      'fcmToken': fcmToken,
      'status': status,
      'lastLogin': lastLogin,
      'date': date,
      'idActiveAmount': idActiveAmount,
      'idActiveMinThreshold': idActiveMinThreshold,
      'isMember': isMember,
      'kycStatus': kycStatus,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id']?.toInt() ?? 0,
      dp: map['dp'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      pinCode: map['pinCode'] ?? '',
      referCode: map['referCode'] ?? '',
      level: map['level']?.toInt() ?? 0,
      firstService: map['firstService'] ?? '',
      referrerCode: map['referrerCode'] ?? '',
      fcmToken: map['fcmToken'],
      status: map['status'] ?? '',
      lastLogin: map['lastLogin'] ?? '',
      date: map['date'] ?? '',
      idActiveAmount: parseToDouble(map['idActiveAmount']),
      idActiveMinThreshold: parseToDouble(map['idActiveMinThreshold']),
      isMember: map['isMember'] == "true",
      kycStatus: map['kycStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, dp: $dp, name: $name, phone: $phone, email: $email, state: $state, city: $city, pinCode: $pinCode, referCode: $referCode, level: $level, firstService: $firstService, referrerCode: $referrerCode, fcmToken: $fcmToken, status: $status, lastLogin: $lastLogin, date: $date, idActiveAmount: $idActiveAmount, idActiveMinThreshold: $idActiveMinThreshold, isMember: $isMember, kycStatus: $kycStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.id == id &&
        other.dp == dp &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.state == state &&
        other.city == city &&
        other.pinCode == pinCode &&
        other.referCode == referCode &&
        other.level == level &&
        other.firstService == firstService &&
        other.referrerCode == referrerCode &&
        other.fcmToken == fcmToken &&
        other.status == status &&
        other.lastLogin == lastLogin &&
        other.date == date &&
        other.idActiveAmount == idActiveAmount &&
        other.idActiveMinThreshold == idActiveMinThreshold &&
        other.isMember == isMember &&
        other.kycStatus == kycStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dp.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        state.hashCode ^
        city.hashCode ^
        pinCode.hashCode ^
        referCode.hashCode ^
        level.hashCode ^
        firstService.hashCode ^
        referrerCode.hashCode ^
        fcmToken.hashCode ^
        status.hashCode ^
        lastLogin.hashCode ^
        date.hashCode ^
        idActiveAmount.hashCode ^
        idActiveMinThreshold.hashCode ^
        isMember.hashCode ^
        kycStatus.hashCode;
  }
}
