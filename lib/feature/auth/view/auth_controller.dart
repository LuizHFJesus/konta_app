import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o e-mail';
    if (!RegExp(
      r'^[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Precisa de letra minúscula';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Precisa de letra maiúscula';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Precisa de número';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>\-+=\[\]\\/;]').hasMatch(value)) {
      return 'Precisa de caractere especial';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != passwordController.text) return 'As senhas não coincidem';
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
