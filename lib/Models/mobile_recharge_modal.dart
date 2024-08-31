import 'dart:convert';

class Mobile_Recharge_Modal {
  String? providerId = "";
  String? providerName = "";
  String? providerImage = "";
  String? circle = "";
  String? customerName = "";
  String? customerPhone = "";
  String? planAmount = "";
  Mobile_Recharge_Modal({
    this.providerId,
    this.providerName,
    this.providerImage,
    this.circle,
    this.customerName,
    this.customerPhone,
    this.planAmount,
  });

  Mobile_Recharge_Modal copyWith({
    String? providerId,
    String? providerName,
    String? providerImage,
    String? circle,
    String? customerName,
    String? customerPhone,
    String? planAmount,
  }) {
    return Mobile_Recharge_Modal(
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
      'providerId': providerId,
      'providerName': providerName,
      'providerImage': providerImage,
      'circle': circle,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'planAmount': planAmount,
    };
  }

  factory Mobile_Recharge_Modal.fromMap(Map<String, dynamic> map) {
    return Mobile_Recharge_Modal(
      providerId: map['providerId'],
      providerName: map['providerName'],
      providerImage: map['providerImage'],
      circle: map['circle'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      planAmount: map['planAmount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mobile_Recharge_Modal.fromJson(String source) =>
      Mobile_Recharge_Modal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mobile_Recharge_Modal(providerId: $providerId, providerName: $providerName, providerImage: $providerImage, circle: $circle, customerName: $customerName, customerPhone: $customerPhone, planAmount: $planAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Mobile_Recharge_Modal &&
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
    return providerId.hashCode ^
        providerName.hashCode ^
        providerImage.hashCode ^
        circle.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        planAmount.hashCode;
  }
}
