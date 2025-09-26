import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:konta_app/app/i18n/locales/en_us.dart';
import 'package:konta_app/app/i18n/locales/pt_br.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': ptBR,
    'en_US': enUS,
  };
}