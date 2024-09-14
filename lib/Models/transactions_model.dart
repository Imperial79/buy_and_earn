import 'dart:convert';

class Transactions_Model {
  int id = 0;
  int customerId = 0;
  String title = "";
  double amount = 0.0;
  Map<String, dynamic> paymentBreakdown = {};
  String type = "";
  String source = "";
  String status = "";
  String date = "";
  Transactions_Model({
    required this.id,
    required this.customerId,
    required this.title,
    required this.amount,
    required this.paymentBreakdown,
    required this.type,
    required this.source,
    required this.status,
    required this.date,
  });

  Transactions_Model copyWith({
    int? id,
    int? customerId,
    String? title,
    double? amount,
    String? type,
    String? source,
    String? status,
    String? date,
  }) {
    return Transactions_Model(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      paymentBreakdown: paymentBreakdown ?? this.paymentBreakdown,
      type: type ?? this.type,
      source: source ?? this.source,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'title': title,
      'amount': amount,
      'type': type,
      'source': source,
      'status': status,
      'date': date,
    };
  }

  factory Transactions_Model.fromMap(Map<String, dynamic> map) {
    return Transactions_Model(
      id: map['id']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      title: map['title'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      paymentBreakdown: jsonDecode(map['paymentBreakdown'] ?? '{}'),
      type: map['type'] ?? '',
      source: map['source'] ?? '',
      status: map['status'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions_Model.fromJson(String source) =>
      Transactions_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transactions_Model(id: $id, customerId: $customerId, title: $title, amount: $amount, type: $type, source: $source, status: $status, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transactions_Model &&
        other.id == id &&
        other.customerId == customerId &&
        other.title == title &&
        other.amount == amount &&
        other.type == type &&
        other.source == source &&
        other.status == status &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        source.hashCode ^
        status.hashCode ^
        date.hashCode;
  }
}
