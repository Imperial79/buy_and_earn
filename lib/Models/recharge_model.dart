import 'dart:convert';

import 'package:buy_and_earn/Utils/commons.dart';

class Recharge_Model {
  String service = "";
  int? providerId = 0;
  String? providerName = "";
  String? providerImage = "";
  String? circle = "";
  String? consumerNo = "";
  double? planAmount = 0.0;
  Recharge_Model({
    required this.service,
    this.providerId,
    this.providerName,
    this.providerImage,
    this.circle,
    this.consumerNo,
    this.planAmount,
  });

  Recharge_Model copyWith({
    String? service,
    int? providerId,
    String? providerName,
    String? providerImage,
    String? circle,
    String? consumerNo,
    double? planAmount,
  }) {
    return Recharge_Model(
      service: service ?? this.service,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      providerImage: providerImage ?? this.providerImage,
      circle: circle ?? this.circle,
      consumerNo: consumerNo ?? this.consumerNo,
      planAmount: planAmount ?? this.planAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'providerId': providerId,
      'providerName': providerName,
      'providerImage': providerImage,
      'circle': circle,
      'consumerNo': consumerNo,
      'planAmount': planAmount,
    };
  }

  factory Recharge_Model.fromMap(Map<String, dynamic> map) {
    return Recharge_Model(
      service: map['service'] ?? '',
      providerId: map['providerId']?.toInt(),
      providerName: map['providerName'],
      providerImage: map['providerImage'],
      circle: map['circle'],
      consumerNo: map['consumerNo'],
      planAmount: parseToDouble(map['planAmount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recharge_Model.fromJson(String source) =>
      Recharge_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Recharge_Model(service: $service, providerId: $providerId, providerName: $providerName, providerImage: $providerImage, circle: $circle, consumerNo: $consumerNo, planAmount: $planAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recharge_Model &&
        other.service == service &&
        other.providerId == providerId &&
        other.providerName == providerName &&
        other.providerImage == providerImage &&
        other.circle == circle &&
        other.consumerNo == consumerNo &&
        other.planAmount == planAmount;
  }

  @override
  int get hashCode {
    return service.hashCode ^
        providerId.hashCode ^
        providerName.hashCode ^
        providerImage.hashCode ^
        circle.hashCode ^
        consumerNo.hashCode ^
        planAmount.hashCode;
  }
}
