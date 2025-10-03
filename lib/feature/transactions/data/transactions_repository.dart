import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

abstract class TransactionsRepository {
  Stream<Either<Failure, List<Transaction>>> listenTransactions();

  Future<Either<Failure, void>> createTransaction({
    required TransactionType type,
    required double amount,
    required DateTime date,
    required String categoryId,
    required String accountId,
    String? description,
  });

  Future<Either<Failure, void>> updateTransaction(Transaction transaction);

  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
