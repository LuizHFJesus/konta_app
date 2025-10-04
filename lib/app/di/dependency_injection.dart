import 'package:get_it/get_it.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository_mock.dart';
import 'package:konta_app/feature/accounts/ui/controllers/account_form_controller.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository_mock.dart';
import 'package:konta_app/feature/auth/view/auth_controller.dart';
import 'package:konta_app/feature/categories/data/repositories/category_repository.dart';
import 'package:konta_app/feature/categories/data/repositories/category_repository_mock.dart';
import 'package:konta_app/feature/categories/ui/controllers/categories_controller.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository_mock.dart';
import 'package:konta_app/feature/transactions/domain/usecases/create_transaction_usecase.dart';
import 'package:konta_app/feature/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:konta_app/feature/transactions/domain/usecases/update_transaction_usecase.dart';
import 'package:konta_app/feature/transactions/ui/controllers/transactions_controller.dart';
import 'package:konta_app/feature/transactions/ui/controllers/transactions_form_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(AuthRepositoryMock.new);
  getIt.registerLazySingleton<AccountRepository>(AccountRepositoryMock.new);
  getIt.registerLazySingleton<TransactionsRepository>(
    TransactionsRepositoryMock.new,
  );
  getIt.registerLazySingleton<CategoryRepository>(CategoryRepositoryMock.new);

  // UseCases
  getIt.registerFactory<CreateTransactionUsecase>(
    () => CreateTransactionUsecase(
      transactionRepository: getIt(),
      accountRepository: getIt(),
    ),
  );
  getIt.registerFactory<UpdateTransactionUsecase>(
    () => UpdateTransactionUsecase(
      transactionRepository: getIt(),
      accountRepository: getIt(),
    ),
  );
  getIt.registerFactory<DeleteTransactionUsecase>(
    () => DeleteTransactionUsecase(
      transactionRepository: getIt(),
      accountRepository: getIt(),
    ),
  );

  // Controllers
  getIt.registerLazySingleton<AuthController>(AuthController.new);
  getIt.registerLazySingleton<AccountsController>(AccountsController.new);
  getIt.registerFactory<AccountFormController>(AccountFormController.new);
  getIt.registerLazySingleton<TransactionsController>(
    TransactionsController.new,
  );
  getIt.registerFactory<TransactionFormController>(
    TransactionFormController.new,
  );
  getIt.registerLazySingleton<CategoriesController>(CategoriesController.new);
}
