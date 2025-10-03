import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/transactions/domain/transaction.dart';

abstract class TransactionsRepository {
  Stream<Either<Failure, List<Transaction>>> listenTransactions();

  Future<Either<Failure, void>> createTransaction(
    TransactionType type,
    double amount,
    DateTime date,
    String categoryId,
    String accountId,
    String? description,
  );

  Future<Either<Failure, void>> updateTransaction(Transaction transaction);

  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
