// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Konta';

  @override
  String get appSubtitle => 'Gestão financeira';

  @override
  String get signInSubtitle => 'Entre na sua conta';

  @override
  String get signUpSubtitle => 'Crie uma nova conta';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'Digite seu e-mail';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordHint => 'Digite sua senha';

  @override
  String get confirmPasswordLabel => 'Confirmar senha';

  @override
  String get confirmPasswordHint => 'Digite novamente sua senha';

  @override
  String get signInButton => 'Entrar';

  @override
  String get signUpButton => 'Cadastrar';

  @override
  String get noAccountQuestion => 'Não tem uma conta? Cadastre-se';

  @override
  String get hasAccountQuestion => 'Já tem uma conta? Entre aqui';

  @override
  String get validationEmptyField => 'Este campo não pode ser vazio';

  @override
  String get validationInvalidEmail => 'Por favor, insira um e-mail válido';

  @override
  String get validationPasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres';

  @override
  String get validationPasswordNeedsLowercase =>
      'Precisa conter uma letra minúscula';

  @override
  String get validationPasswordNeedsUppercase =>
      'Precisa conter uma letra maiúscula';

  @override
  String get validationPasswordNeedsNumber => 'Precisa conter um número';

  @override
  String get validationPasswordNeedsSpecialCharacter =>
      'Precisa conter um caractere especial';

  @override
  String get validationPasswordsDoNotMatch => 'As senhas não coincidem';
}
