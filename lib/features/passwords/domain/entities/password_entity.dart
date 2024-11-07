import 'dart:convert';

class PasswordEntity {
  final String? title;
  final String? username;
  final String? password;
  final String? passwordIdentifier;
  final Map<String, String>? creditCardInfo;
  final Map<String, String>? otherFields;

  PasswordEntity({
    this.title,
    this.username,
    this.password,
    this.passwordIdentifier,
    this.creditCardInfo,
    this.otherFields,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'username': username,
      'password': password,
      'passwordIdentifier': passwordIdentifier,
      'creditCardInfo': creditCardInfo,
      'otherFields': otherFields,
    };
  }

  factory PasswordEntity.fromMap(Map<String, dynamic> map) {
    return PasswordEntity(
      title: map['title'] ?? "No title",
      username: map['username'] ?? "No username",
      password: map['password'] ?? "No password",
      passwordIdentifier: map['passwordIdentifier'],
      creditCardInfo: Map<String, String>.from(map['creditCardInfo'] ?? {}),
      otherFields: Map<String, String>.from(map['otherFields'] ?? {}),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PasswordEntity.fromJson(String source) {
    return PasswordEntity.fromMap(jsonDecode(source));
  }
}
