import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class DeleteTransactionUsecase {
  final TransactionsRepository _transactionRepository;
  final AccountRepository _accountRepository;

  DeleteTransactionUsecase({
    required TransactionsRepository transactionRepository,
    required AccountRepository accountRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository;

  Future<Either<Failure, void>> call(Transaction transaction) async {
    final amountToRevert = transaction.type == TransactionType.income
        ? -transaction.amount
        : transaction.amount;

    final response = await _accountRepository.updateAccountBalance(
      accountId: transaction.accountId,
      amount: amountToRevert,
    );

    if (response.isLeft) return response;

    return _transactionRepository.deleteTransaction(transaction.id);
  }
}
