import 'package:get_it/get_it.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository_mock.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository_mock.dart';
import 'package:konta_app/feature/auth/view/auth_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(AuthRepositoryMock.new);
  getIt.registerLazySingleton<AccountRepository>(AccountRepositoryMock.new);

  // Controllers
  getIt.registerLazySingleton<AuthController>(AuthController.new);
  getIt.registerLazySingleton<AccountsController>(AccountsController.new);
}
