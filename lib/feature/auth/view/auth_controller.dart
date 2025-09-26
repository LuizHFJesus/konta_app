import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/app/navigation/app_routes.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _repository = getIt<AuthRepository>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final RxBool _obscurePassword = true.obs;
  final RxBool _isSubmitting = false.obs;
  final RxBool _isLoginMode = true.obs;
  final RxString _errorMessage = ''.obs;

  bool get obscurePassword => _obscurePassword.value;
  bool get isSubmitting => _isSubmitting.value;
  bool get isLoginMode => _isLoginMode.value;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    if (!RegExp(
      r'^[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(value)) {
      return 'validation_invalid_email'.tr;
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    if (value.length < 8) return 'validation_password_too_short'.tr;
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'validation_password_needs_lowercase'.tr;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'validation_password_needs_uppercase'.tr;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'validation_password_needs_number'.tr;
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>\-+=\[\]\\/;]').hasMatch(value)) {
      return 'validation_password_needs_special_character'.tr;
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    if (value != passwordController.text) {
      return 'validation_passwords_do_not_match'.tr;
    }

    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    if (!RegExp(r'^[a-zA-ZÀ-ú\s]+$').hasMatch(value)) {
      return 'validation_name_invalid_chars'.tr;
    }
    return null;
  }

  void toggleObscurePassword() =>
      _obscurePassword.value = !_obscurePassword.value;

  Future<void> submit(BuildContext context) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    _errorMessage.value = '';
    if (isLoginMode) {
      await login(context);
    } else {
      await register();
    }
    _isSubmitting.value = false;
  }

  Future<void> login(BuildContext context) async {
    final response = await _repository.signInWithPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) {
        _clearFields();
        context.go(AppRoutes.home);
      },
    );
  }

  Future<void> register() async {
    final response = await _repository.signUp(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) {
        _isLoginMode.value = true;
        _clearFields();
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
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
    nameController.clear();
  }
}
