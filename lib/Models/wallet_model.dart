import 'dart:convert';

import 'package:buy_and_earn/Utils/commons.dart';

class WalletModel {
  int id = 0;
  int customerId = 0;
  double selfCashback = 0.0;
  double levelCommission = 0.0;
  double workingBonus = 0.0;
  double reward = 0.0;
  double clubhouseCommission = 0.0;
  double royalAchieversCommission = 0.0;
  double lastMonthTdsDeducted = 0.0;
  double balance = 0.0;
  double lastMonthCommissionEarned = 0.0;

  WalletModel({
    required this.id,
    required this.customerId,
    required this.selfCashback,
    required this.levelCommission,
    required this.workingBonus,
    required this.reward,
    required this.clubhouseCommission,
    required this.royalAchieversCommission,
    required this.lastMonthTdsDeducted,
    required this.balance,
    required this.lastMonthCommissionEarned,
  });

  WalletModel copyWith({
    int? id,
    int? customerId,
    double? selfCashback,
    double? levelCommission,
    double? workingBonus,
    double? reward,
    double? clubhouseCommission,
    double? royalAchieversCommission,
    double? lastMonthTdsDeducted,
    double? balance,
    double? lastMonthCommissionEarned,
  }) {
    return WalletModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      selfCashback: selfCashback ?? this.selfCashback,
      levelCommission: levelCommission ?? this.levelCommission,
      workingBonus: workingBonus ?? this.workingBonus,
      reward: reward ?? this.reward,
      clubhouseCommission: clubhouseCommission ?? this.clubhouseCommission,
      royalAchieversCommission:
          royalAchieversCommission ?? this.royalAchieversCommission,
      lastMonthTdsDeducted: lastMonthTdsDeducted ?? this.lastMonthTdsDeducted,
      balance: balance ?? this.balance,
      lastMonthCommissionEarned:
          lastMonthCommissionEarned ?? this.lastMonthCommissionEarned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'selfCashback': selfCashback,
      'levelCommission': levelCommission,
      'workingBonus': workingBonus,
      'reward': reward,
      'clubhouseCommission': clubhouseCommission,
      'royalAchieversCommission': royalAchieversCommission,
      'lastMonthTdsDeducted': lastMonthTdsDeducted,
      'balance': balance,
      'lastMonthCommissionEarned': lastMonthCommissionEarned,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      selfCashback: parseToDouble(map['selfCashback']),
      levelCommission: parseToDouble(map['levelCommission']),
      workingBonus: parseToDouble(map['workingBonus']),
      reward: parseToDouble(map['reward']),
      clubhouseCommission: parseToDouble(map['clubhouseCommission']),
      royalAchieversCommission: parseToDouble(map['royalAchieversCommission']),
      lastMonthTdsDeducted: parseToDouble(map['lastMonthTdsDeducted']),
      balance: parseToDouble(map['balance']),
      lastMonthCommissionEarned:
          parseToDouble(map['lastMonthCommissionEarned']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));
}
