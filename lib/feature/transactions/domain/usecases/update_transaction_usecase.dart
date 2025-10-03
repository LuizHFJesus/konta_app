import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class UpdateTransactionUsecase {
  final TransactionsRepository _transactionRepository;
  final AccountRepository _accountRepository;

  UpdateTransactionUsecase({
    required TransactionsRepository transactionRepository,
    required AccountRepository accountRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository;

  Future<Either<Failure, void>> call({
    required Transaction newTransaction,
    required Transaction oldTransaction,
  }) async {
    if (oldTransaction.amount != newTransaction.amount ||
        oldTransaction.type != newTransaction.type) {
      final oldAmountToRevert = oldTransaction.type == TransactionType.income
          ? -oldTransaction.amount
          : oldTransaction.amount;

      Either<Failure, void> response;
      response = await _accountRepository.updateAccountBalance(
        accountId: oldTransaction.accountId,
        amount: oldAmountToRevert,
      );
      if (response.isLeft) return response;

      final newAmountToApply = newTransaction.type == TransactionType.income
          ? newTransaction.amount
          : -newTransaction.amount;

      response = await _accountRepository.updateAccountBalance(
        accountId: newTransaction.accountId,
        amount: newAmountToApply,
      );
      if (response.isLeft) return response;
    }

    return _transactionRepository.updateTransaction(newTransaction);
  }
}
