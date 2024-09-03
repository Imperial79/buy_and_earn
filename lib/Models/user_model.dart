import 'dart:convert';

class UserModel {
  int id = 0;
  String name = "";
  String phone = "";
  String? email;
  String state = "";
  String city = "";
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
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.state,
    required this.city,
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
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? state,
    String? city,
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
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      state: state ?? this.state,
      city: city ?? this.city,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'state': state,
      'city': city,
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
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      referCode: map['referCode'] ?? '',
      level: map['level']?.toInt() ?? 0,
      firstService: map['firstService'] ?? '',
      referrerCode: map['referrerCode'] ?? '',
      fcmToken: map['fcmToken'],
      status: map['status'] ?? '',
      lastLogin: map['lastLogin'] ?? '',
      date: map['date'] ?? '',
      idActiveAmount: double.parse("${map['idActiveAmount']}"),
      idActiveMinThreshold: double.parse("${map['idActiveMinThreshold']}"),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phone: $phone, email: $email, state: $state, city: $city, referCode: $referCode, level: $level, firstService: $firstService, referrerCode: $referrerCode, fcmToken: $fcmToken, status: $status, lastLogin: $lastLogin, date: $date, idActiveAmount: $idActiveAmount, idActiveMinThreshold: $idActiveMinThreshold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.state == state &&
        other.city == city &&
        other.referCode == referCode &&
        other.level == level &&
        other.firstService == firstService &&
        other.referrerCode == referrerCode &&
        other.fcmToken == fcmToken &&
        other.status == status &&
        other.lastLogin == lastLogin &&
        other.date == date &&
        other.idActiveAmount == idActiveAmount &&
        other.idActiveMinThreshold == idActiveMinThreshold;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        state.hashCode ^
        city.hashCode ^
        referCode.hashCode ^
        level.hashCode ^
        firstService.hashCode ^
        referrerCode.hashCode ^
        fcmToken.hashCode ^
        status.hashCode ^
        lastLogin.hashCode ^
        date.hashCode ^
        idActiveAmount.hashCode ^
        idActiveMinThreshold.hashCode;
  }
}
