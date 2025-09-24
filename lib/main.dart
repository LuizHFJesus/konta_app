import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/app/l10n/app_localizations.dart';
import 'package:konta_app/app/navigation/AppRouter.dart';
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

    return MaterialApp.router(
      title: 'Konta',
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter().router,
    );
  }
}
