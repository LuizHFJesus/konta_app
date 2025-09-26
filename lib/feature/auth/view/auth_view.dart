import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/app/l10n/app_localizations.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
import 'package:konta_app/common/widgets/custom_text_button.dart';
import 'package:konta_app/feature/auth/view/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController controller = getIt<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Center(
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 30),
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    if (!controller.isLoginMode) ...[
                      const SizedBox(height: 20),
                      _buildConfirmPasswordField(),
                      const SizedBox(height: 20),
                      _buildNameField(),
                    ],
                    const SizedBox(height: 30),
                    _buildSubmitButton(context),
                    _buildToggleModeButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/app_logo_primary.svg',
          height: 132,
        ),
        const SizedBox(height: 20),
        Text(
          '${'app_name'.tr}\n${'app_subtitle'.tr}',
          style: GoogleFonts.bowlbyOneSc(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Theme.of(context).colorScheme.primaryContainer
                : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          controller.isLoginMode
              ? 'sign_in_subtitle'.tr
              : 'sign_up_subtitle'.tr,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'email_label'.tr,
        hintText: 'email_hint'.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: controller.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: controller.obscurePassword,
      textInputAction: controller.isLoginMode
          ? TextInputAction.done
          : TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'password_label'.tr,
        hintText: 'password_hint'.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: controller.toggleObscurePassword,
        ),
      ),
      validator: controller.validatePassword,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: controller.obscurePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'confirm_password_label'.tr,
        hintText: 'confirm_password_hint'.tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: controller.toggleObscurePassword,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: controller.validateConfirmPassword,
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: controller.nameController,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'name_label'.tr,
        hintText: 'name_hint'.tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: controller.validateName,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      text: controller.isLoginMode ? 'sign_in_button'.tr : 'sign_up_button'.tr,
      isSubmitting: controller.isSubmitting,
      onPressed: () => controller.submit(context),
    );
  }

  Widget _buildToggleModeButton() {
    return CustomTextButton(
      text: controller.isLoginMode
          ? 'no_account_question'.tr
          : 'has_account_question'.tr,
      onPressed: controller.isSubmitting ? null : controller.toggleMode,
    );
  }
}
