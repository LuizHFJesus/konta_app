import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/app/i18n/app_translations.dart';
import 'package:konta_app/app/navigation/app_router.dart';
import 'package:konta_app/app/theme/custom_text_theme.dart';
import 'package:konta_app/app/theme/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'Vazirmatn', 'Vazirmatn');
    final theme = MaterialTheme(textTheme);
    final router = AppRouter().router;

    return GetMaterialApp.router(
      title: 'Konta',
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,

      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,

      fallbackLocale: const Locale('pt', 'BR'),
      locale: Get.deviceLocale,
      translations: AppTranslations(),
    );
  }
}
