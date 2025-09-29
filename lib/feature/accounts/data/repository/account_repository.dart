import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';

abstract class AccountRepository {
  Stream<Either<Failure, List<Account>>> watchAccounts();

  Future<Either<Failure, void>> addAccount({
    required String name,
    required double balance,
    required int iconCodePoint,
    required int colorValue,
  });

  Future<Either<Failure, void>> updateAccount(Account account);

  Future<Either<Failure, void>> deleteAccount(String accountId);
}
