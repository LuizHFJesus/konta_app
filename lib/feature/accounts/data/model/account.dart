import 'package:flutter/material.dart';

class Account {
  final String id;
  final String name;
  final double balance;
  final int iconCodePoint;
  final int colorValue;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.iconCodePoint,
    required this.colorValue,
  });

  Account copyWith({
    String? id,
    String? name,
    double? balance,
    int? iconCodePoint,
    int? colorValue,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  Color get color => Color(colorValue);

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'iconCodePoint': iconCodePoint,
      'colorValue': colorValue,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
      iconCodePoint: map['iconCodePoint'] as int,
      colorValue: map['colorValue'] as int,
    );
  }
}
