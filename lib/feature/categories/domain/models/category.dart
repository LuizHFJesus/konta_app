import 'package:flutter/material.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class Category {
  final String id;
  final TransactionType type;
  final String name;
  final int iconCodePoint;
  final int colorValue;

  Category({
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

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      type: map['type'] as TransactionType,
      name: map['name'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      colorValue: map['colorValue'] as int,
    );
  }
}
