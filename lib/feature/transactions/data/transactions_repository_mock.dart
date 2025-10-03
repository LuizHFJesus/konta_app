import 'dart:async';
import 'dart:math';

import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class TransactionsRepositoryMock implements TransactionsRepository {
  final List<Transaction> _transactions = [];

  final _streamController =
      StreamController<Either<Failure, List<Transaction>>>.broadcast();

  void _updateStream() {
    _streamController.add(Right(List.from(_transactions)));
  }

  @override
  Stream<Either<Failure, List<Transaction>>> listenTransactions() async* {
    yield Right(List.from(_transactions));

    yield* _streamController.stream;
  }

  @override
  Future<Either<Failure, void>> createTransaction({
    required TransactionType type,
    required double amount,
    required DateTime date,
    required String categoryId,
    required String accountId,
    String? description,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final newTransaction = Transaction(
        id: Random().nextInt(9999).toString(),
        type: type,
        amount: amount,
        date: date,
        categoryId: categoryId,
        accountId: accountId,
        description: description,
      );

      _transactions.add(newTransaction);
      _updateStream();

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao criar transação (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(
    Transaction transaction,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
        _updateStream();
        return const Right(null);
      } else {
        return Left(Failure('Transação não encontrada para atualizar (mock).'));
      }
    } catch (e) {
      return Left(Failure('Erro ao atualizar trasação (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final initialLength = _transactions.length;
      _transactions.removeWhere((t) => t.id == transactionId);

      if (_transactions.length < initialLength) {
        _updateStream();
        return const Right(null);
      } else {
        return Left(Failure('Transação não encontrada para deletar (mock).'));
      }
    } catch (e) {
      return Left(Failure('Erro ao deletar transação (mock).'));
    }
  }

  Future<void> dispose() async {
    await _streamController.close();
  }
}
