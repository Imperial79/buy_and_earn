import 'dart:convert';

class ResponseModel {
  bool error = false;
  String message = "";
  dynamic response;
  String? action;
  ResponseModel({
    required this.error,
    required this.message,
    required this.response,
    this.action,
  });

  ResponseModel copyWith({
    bool? error,
    String? message,
    dynamic response,
    String? action,
  }) {
    return ResponseModel(
      error: error ?? this.error,
      message: message ?? this.message,
      response: response ?? this.response,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'response': response,
      'action': action,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      response: map['response'] ?? null,
      action: map['action'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseModel(error: $error, message: $message, response: $response, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.error == error &&
        other.message == message &&
        other.response == response &&
        other.action == action;
  }

  @override
  int get hashCode {
    return error.hashCode ^
        message.hashCode ^
        response.hashCode ^
        action.hashCode;
  }
}
