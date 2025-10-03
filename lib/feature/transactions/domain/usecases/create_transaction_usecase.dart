import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class CreateTransactionUsecase {
  final TransactionsRepository _transactionRepository;
  final AccountRepository _accountRepository;

  CreateTransactionUsecase({
    required TransactionsRepository transactionRepository,
    required AccountRepository accountRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository;

  Future<Either<Failure, void>> call({
    required TransactionType type,
    required double amount,
    required DateTime date,
    required String categoryId,
    required String accountId,
    String? description,
  }) async {
    final response = await _transactionRepository.createTransaction(
      type: type,
      amount: amount,
      date: date,
      categoryId: categoryId,
      accountId: accountId,
      description: description,
    );

    if (response.isLeft) return response;

    final amountToUpdate = (type == TransactionType.income) ? amount : -amount;
    return _accountRepository.updateAccountBalance(
      accountId: accountId,
      amount: amountToUpdate,
    );
  }
}
