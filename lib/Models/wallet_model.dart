import 'dart:convert';

class WalletModel {
  int? id;
  int? userId;
  double? selfCashback;
  double? referralIncome;
  double? workingBonus;
  double? reward;
  double? tds;
  double? balance;
  String? monthYear;
  WalletModel({
    this.id,
    this.userId,
    this.selfCashback,
    this.referralIncome,
    this.workingBonus,
    this.reward,
    this.tds,
    this.balance,
    this.monthYear,
  });

  WalletModel copyWith({
    int? id,
    int? userId,
    double? selfCashback,
    double? referralIncome,
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
      referralIncome: referralIncome ?? this.referralIncome,
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
      'referralIncome': referralIncome,
      'workingBonus': workingBonus,
      'reward': reward,
      'tds': tds,
      'balance': balance,
      'monthYear': monthYear,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      userId: map['userId'],
      selfCashback: double.parse("${map['selfCashback']}"),
      referralIncome: double.parse("${map['referralIncome']}"),
      workingBonus: double.parse("${map['workingBonus']}"),
      reward: double.parse("${map['reward']}"),
      tds: double.parse("${map['tds']}"),
      balance: double.parse("${map['balance']}"),
      monthYear: map['monthYear'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, userId: $userId, selfCashback: $selfCashback, referralIncome: $referralIncome, workingBonus: $workingBonus, reward: $reward, tds: $tds, balance: $balance, monthYear: $monthYear)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.id == id &&
        other.userId == userId &&
        other.selfCashback == selfCashback &&
        other.referralIncome == referralIncome &&
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
        referralIncome.hashCode ^
        workingBonus.hashCode ^
        reward.hashCode ^
        tds.hashCode ^
        balance.hashCode ^
        monthYear.hashCode;
  }
}
