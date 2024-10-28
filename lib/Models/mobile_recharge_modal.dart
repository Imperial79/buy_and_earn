import 'dart:convert';

import 'package:buy_and_earn/Utils/commons.dart';

class Mobile_Recharge_Model {
  String service = "";
  int? providerId = 0;
  String? providerName = "";
  String? providerImage = "";
  String? circle = "";
  String? customerName = "";
  String? customerPhone = "";
  double? planAmount = 0.0;
  Mobile_Recharge_Model({
    required this.service,
    this.providerId,
    this.providerName,
    this.providerImage,
    this.circle,
    this.customerName,
    this.customerPhone,
    this.planAmount,
  });

  Mobile_Recharge_Model copyWith({
    String? service,
    int? providerId,
    String? providerName,
    String? providerImage,
    String? circle,
    String? customerName,
    String? customerPhone,
    double? planAmount,
  }) {
    return Mobile_Recharge_Model(
      service: service ?? this.service,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      providerImage: providerImage ?? this.providerImage,
      circle: circle ?? this.circle,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
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
      'customerName': customerName,
      'customerPhone': customerPhone,
      'planAmount': planAmount,
    };
  }

  factory Mobile_Recharge_Model.fromMap(Map<String, dynamic> map) {
    return Mobile_Recharge_Model(
      service: map['service'] ?? '',
      providerId: map['providerId']?.toInt(),
      providerName: map['providerName'],
      providerImage: map['providerImage'],
      circle: map['circle'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      planAmount: parseToDouble(map['planAmount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mobile_Recharge_Model.fromJson(String source) =>
      Mobile_Recharge_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mobile_Recharge_Model(service: $service, providerId: $providerId, providerName: $providerName, providerImage: $providerImage, circle: $circle, customerName: $customerName, customerPhone: $customerPhone, planAmount: $planAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Mobile_Recharge_Model &&
        other.service == service &&
        other.providerId == providerId &&
        other.providerName == providerName &&
        other.providerImage == providerImage &&
        other.circle == circle &&
        other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.planAmount == planAmount;
  }

  @override
  int get hashCode {
    return service.hashCode ^
        providerId.hashCode ^
        providerName.hashCode ^
        providerImage.hashCode ^
        circle.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        planAmount.hashCode;
  }
}
