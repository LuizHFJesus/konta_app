import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konta_app/app/l10n/app_localizations.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _obscurePassword = true.obs;
  final _isSubmitting = false.obs;
  final _isLoginMode = true.obs;

  bool get obscurePassword => _obscurePassword.value;
  bool get isSubmitting => _isSubmitting.value;
  bool get isLoginMode => _isLoginMode.value;

  String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validationEmptyField;
    if (!RegExp(
      r'^[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(value)) {
      return l10n.validationInvalidEmail;
    }

    return null;
  }

  String? validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validationEmptyField;
    if (value.length < 8) return l10n.validationPasswordTooShort;
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return l10n.validationPasswordNeedsLowercase;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return l10n.validationPasswordNeedsUppercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return l10n.validationPasswordNeedsNumber;
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>\-+=\[\]\\/;]').hasMatch(value)) {
      return l10n.validationPasswordNeedsSpecialCharacter;
    }

    return null;
  }

  String? validateConfirmPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validationEmptyField;
    if (value != passwordController.text) {
      return l10n.validationPasswordsDoNotMatch;
    }

    return null;
  }

  void toggleObscurePassword() =>
      _obscurePassword.value = !_obscurePassword.value;

  Future<void> submit() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));
    if (isLoginMode) {
      await login();
    } else {
      await register();
    }
  }

  Future<void> login() async {
    _isSubmitting.value = false;
  }

  Future<void> register() async {
    _isSubmitting.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleMode() {
    _isLoginMode.value = !_isLoginMode.value;
    _isSubmitting.value = false;
    _clearFields();
    _obscurePassword.value = true;
    update();
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
