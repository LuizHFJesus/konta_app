import 'dart:async';
import 'dart:math';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';

class AccountRepositoryMock implements AccountRepository {
  final List<Account> _accounts = [
    Account(
      id: '00001',
      name: 'PicPay',
      balance: 1000,
      iconCodePoint: Icons.savings.codePoint,
      colorValue: const Color(0xFF95C940).toARGB32(),
    ),

    Account(
      id: '00002',
      name: 'BTG',
      balance: 1000,
      iconCodePoint: Icons.attach_money.codePoint,
      colorValue: const Color(0xFF4570B5).toARGB32(),
    ),
  ];

  @override
  Future<Either<Failure, List<Account>>> getAccounts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(_accounts);
    } catch (e) {
      return Left(Failure('Erro ao carregar contas (mock).'));
    }
  }

  @override
  Future<Either<Failure, Account>> getAccountById(String accountId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final account = _accounts.firstWhereOrNull((acc) => acc.id == accountId);
      if (account != null) {
        return Right(account);
      } else {
        return Left(Failure('Conta não encontrada para atualizar (mock).'));
      }
    } catch (e) {
      return Left(Failure('Erro ao atualizar conta (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> createAccount({
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
      } else {
        return Left(Failure('Conta não encontrada para atualizar (mock).'));
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao atualizar conta (mock).'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccountBalance({
    required String accountId,
    required double amount,
  }) async {
    final index = _accounts.indexWhere((acc) => acc.id == accountId);
    if (index != -1) {
      final account = _accounts[index];
      _accounts[index] = account.copyWith(
          balance: account.balance + amount);
      return const Right(null);
    } else {
      return Left(Failure('Conta não encontrada para atualizar saldo.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String accountId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      _accounts.removeWhere((acc) => acc.id == accountId);

      return const Right(null);
    } catch (e) {
      return Left(Failure('Erro ao deletar conta (mock).'));
    }
  }
}
