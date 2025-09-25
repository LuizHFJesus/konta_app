// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Konta';

  @override
  String get appSubtitle => 'Financial management';

  @override
  String get signInSubtitle => 'Sign in to your account';

  @override
  String get signUpSubtitle => 'Create a new account';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Enter your password again';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get signInButton => 'Sign in';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get noAccountQuestion => 'Don\'t have an account? Sign up';

  @override
  String get hasAccountQuestion => 'Already have an account? Sign in here';

  @override
  String get validationEmptyField => 'This field cannot be empty';

  @override
  String get validationInvalidEmail => 'Please enter a valid email address';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters long';

  @override
  String get validationPasswordNeedsLowercase =>
      'Must contain a lowercase letter';

  @override
  String get validationPasswordNeedsUppercase =>
      'Must contain an uppercase letter';

  @override
  String get validationPasswordNeedsNumber => 'Must contain a number';

  @override
  String get validationPasswordNeedsSpecialCharacter =>
      'Must contain a special character';

  @override
  String get validationNameInvalidChars =>
      'Name must only contain letters and spaces';

  @override
  String get validationPasswordsDoNotMatch => 'The passwords do not match';
}
