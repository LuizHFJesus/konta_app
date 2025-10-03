import 'package:flutter/material.dart';
import 'package:konta_app/feature/transactions/domain/transaction.dart';

class TransactionCategory {
  final String id;
  final TransactionType type;
  final String name;
  final int iconCodePoint;
  final int colorValue;

  TransactionCategory({
    required this.id,
    required this.type,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
  });

  Color get color => Color(colorValue);

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'iconCodePoint': iconCodePoint,
      'colorValue': colorValue,
    };
  }

  factory TransactionCategory.fromJson(Map<String, dynamic> map) {
    return TransactionCategory(
      id: map['id'] as String,
      type: map['type'] as TransactionType,
      name: map['name'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      colorValue: map['colorValue'] as int,
    );
  }
}
