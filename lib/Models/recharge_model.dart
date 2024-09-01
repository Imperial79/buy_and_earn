import 'dart:convert';

class Recharge_Model {
  String service = "";
  String? providerId = "";
  String? providerName = "";
  String? providerImage = "";
  String? circle = "";
  String? consumerNo = "";
  String? planAmount = "";
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
    String? providerId,
    String? providerName,
    String? providerImage,
    String? circle,
    String? consumerNo,
    String? planAmount,
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
      providerId: map['providerId'],
      providerName: map['providerName'],
      providerImage: map['providerImage'],
      circle: map['circle'],
      consumerNo: map['consumerNo'],
      planAmount: map['planAmount'],
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
