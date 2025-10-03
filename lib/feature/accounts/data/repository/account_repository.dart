import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<Account>>> getAccounts();

  Future<Either<Failure, Account>> getAccountById(String accountId);

  Future<Either<Failure, void>> createAccount({
    required String name,
    required double balance,
    required int iconCodePoint,
    required int colorValue,
  });

  Future<Either<Failure, void>> updateAccount(Account account);

  Future<Either<Failure, void>> updateAccountBalance({
    required String accountId,
    required double amount,
  });

  Future<Either<Failure, void>> deleteAccount(String accountId);
}
