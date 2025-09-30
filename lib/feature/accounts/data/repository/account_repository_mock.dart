import 'dart:async';
import 'dart:math';

import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';

class AccountRepositoryMock implements AccountRepository {
  final List<Account> _accounts = [];

  final _accountsStreamController =
      StreamController<Either<Failure, List<Account>>>.broadcast();

  AccountRepositoryMock() {
    _accountsStreamController.add(Right(_accounts));
  }

  @override
  Stream<Either<Failure, List<Account>>> watchAccounts() {
    return _accountsStreamController.stream;
  }

  @override
  Future<Either<Failure, void>> addAccount({
    required String name,
    required double balance,
    required int iconCodePoint,
    required int colorValue,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final newAccount = Account(
        id: Random().nextInt(99999).toString(),
        name: name,
        balance: balance,
        iconCodePoint: iconCodePoint,
        colorValue: colorValue,
      );

      _accounts.add(newAccount);
      _accountsStreamController.add(Right(_accounts));

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao adicionar conta (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccount(Account account) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final index = _accounts.indexWhere((acc) => acc.id == account.id);
      if (index != -1) {
        _accounts[index] = account;
        _accountsStreamController.add(Right(_accounts));
      } else {
        return Left(Failure('Conta não encontrada para atualizar (mock).'));
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao atualizar conta (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String accountId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      _accounts.removeWhere((acc) => acc.id == accountId);
      _accountsStreamController.add(Right(_accounts));

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao deletar conta (mock).'));
    }
  }
}
