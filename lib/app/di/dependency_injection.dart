import 'package:get_it/get_it.dart';
import 'package:konta_app/feature/auth/view/auth_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  // Controllers
  getIt.registerLazySingleton<AuthController>(AuthController.new);
}
