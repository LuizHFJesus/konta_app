enum TransactionType { income, expense }

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String? description;
  final String categoryId;
  final String accountId;

  const Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.accountId,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
      'description': description,
      'categoryId': categoryId,
      'accountId': accountId,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      type: map['type'] as TransactionType,
      amount: map['amount'] as double,
      date: map['date'] as DateTime,
      description: map['description'] as String?,
      categoryId: map['categoryId'] as String,
      accountId: map['accountId'] as String,
    );
  }
}
