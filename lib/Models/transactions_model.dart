import 'dart:convert';

class Transactions_Model {
  int id = 0;
  int customerId = 0;
  String title = "";
  double amount = 0.0;
  String type = "";
  String date = "";
  Map<String, dynamic> paymentBreakdown = {};
  String source = "";
  Transactions_Model({
    required this.id,
    required this.customerId,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.paymentBreakdown,
    required this.source,
  });

  Transactions_Model copyWith({
    int? id,
    int? customerId,
    String? title,
    double? amount,
    String? type,
    String? date,
    Map<String, dynamic>? paymentBreakdown,
    String? source,
  }) {
    return Transactions_Model(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      paymentBreakdown: paymentBreakdown ?? this.paymentBreakdown,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'title': title,
      'amount': amount,
      'type': type,
      'date': date,
      'paymentBreakdown': paymentBreakdown,
      'source': source,
    };
  }

  factory Transactions_Model.fromMap(Map<String, dynamic> map) {
    return Transactions_Model(
      id: map['id'] ?? 0,
      customerId: map['customerId'] ?? 0,
      title: map['title'] ?? '',
      amount: double.parse("${map['amount']}"),
      type: map['type'] ?? '',
      date: map['date'] ?? '',
      paymentBreakdown: jsonDecode(map['paymentBreakdown']),
      source: map['source'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions_Model.fromJson(String source) =>
      Transactions_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transactions_Model(id: $id, customerId: $customerId, title: $title, amount: $amount, type: $type, date: $date, source: $source)';
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
        other.date == date &&
        other.source == source;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        date.hashCode ^
        source.hashCode;
  }
}
