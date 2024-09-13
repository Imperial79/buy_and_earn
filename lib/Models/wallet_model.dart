import 'dart:convert';

class WalletModel {
  int id = 0;
  int userId = 0;
  double selfCashback = 0.0;
  double levelCommission = 0.0;
  double workingBonus = 0.0;
  double reward = 0.0;
  double tds = 0.0;
  double balance = 0.0;
  String monthYear = "";
  WalletModel({
    required this.id,
    required this.userId,
    required this.selfCashback,
    required this.levelCommission,
    required this.workingBonus,
    required this.reward,
    required this.tds,
    required this.balance,
    required this.monthYear,
  });

  WalletModel copyWith({
    int? id,
    int? userId,
    double? selfCashback,
    double? levelCommission,
    double? workingBonus,
    double? reward,
    double? tds,
    double? balance,
    String? monthYear,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      selfCashback: selfCashback ?? this.selfCashback,
      levelCommission: levelCommission ?? this.levelCommission,
      workingBonus: workingBonus ?? this.workingBonus,
      reward: reward ?? this.reward,
      tds: tds ?? this.tds,
      balance: balance ?? this.balance,
      monthYear: monthYear ?? this.monthYear,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'selfCashback': selfCashback,
      'levelCommission': levelCommission,
      'workingBonus': workingBonus,
      'reward': reward,
      'tds': tds,
      'balance': balance,
      'monthYear': monthYear,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      selfCashback: map['selfCashback']?.toDouble() ?? 0.0,
      levelCommission: map['levelCommission']?.toDouble() ?? 0.0,
      workingBonus: map['workingBonus']?.toDouble() ?? 0.0,
      reward: map['reward']?.toDouble() ?? 0.0,
      tds: map['tds']?.toDouble() ?? 0.0,
      balance: map['balance']?.toDouble() ?? 0.0,
      monthYear: map['monthYear'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, userId: $userId, selfCashback: $selfCashback, levelCommission: $levelCommission, workingBonus: $workingBonus, reward: $reward, tds: $tds, balance: $balance, monthYear: $monthYear)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.id == id &&
        other.userId == userId &&
        other.selfCashback == selfCashback &&
        other.levelCommission == levelCommission &&
        other.workingBonus == workingBonus &&
        other.reward == reward &&
        other.tds == tds &&
        other.balance == balance &&
        other.monthYear == monthYear;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        selfCashback.hashCode ^
        levelCommission.hashCode ^
        workingBonus.hashCode ^
        reward.hashCode ^
        tds.hashCode ^
        balance.hashCode ^
        monthYear.hashCode;
  }
}
