import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/transaction/domain/transaction.dart';

abstract class TransactionRepository {
  Stream<Either<Failure, List<Transaction>>> listenTransactions();

  Future<Either<Failure, void>> createTransaction(Transaction transaction);

  Future<Either<Failure, void>> updateTransaction(Transaction transaction);

  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
