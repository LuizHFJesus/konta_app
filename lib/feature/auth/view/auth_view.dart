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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Center(
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context, l10n),
                    const SizedBox(height: 30),
                    _buildEmailField(l10n),
                    const SizedBox(height: 20),
                    _buildPasswordField(l10n),
                    if (!controller.isLoginMode) ...[
                      const SizedBox(height: 20),
                      _buildConfirmPasswordField(l10n),
                      const SizedBox(height: 20),
                      _buildNameField(l10n),
                    ],
                    const SizedBox(height: 30),
                    _buildSubmitButton(l10n),
                    _buildToggleModeButton(l10n),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/app_logo_primary.svg',
          height: 132,
        ),
        const SizedBox(height: 20),
        Text(
          '${l10n.appName}\n${l10n.appSubtitle}',
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
          controller.isLoginMode ? l10n.signInSubtitle : l10n.signUpSubtitle,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildEmailField(AppLocalizations l10n) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.emailLabel,
        hintText: l10n.emailHint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) => controller.validateEmail(value, l10n),
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: controller.obscurePassword,
      textInputAction: controller.isLoginMode
          ? TextInputAction.done
          : TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.passwordLabel,
        hintText: l10n.passwordHint,
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
      validator: (value) => controller.validatePassword(value, l10n),
    );
  }

  Widget _buildConfirmPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: controller.obscurePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: l10n.confirmPasswordLabel,
        hintText: l10n.confirmPasswordHint,
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
      validator: (value) => controller.validateConfirmPassword(value, l10n),
    );
  }

  Widget _buildNameField(AppLocalizations l10n) {
    return TextFormField(
      controller: controller.nameController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.nameLabel,
        hintText: l10n.nameHint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) => controller.validateName(value, l10n),
    );
  }

  Widget _buildSubmitButton(AppLocalizations l10n) {
    return CustomElevatedButton(
      text: controller.isLoginMode
          ? l10n.signInButton
          : l10n.signUpButton,
      isSubmitting: controller.isSubmitting,
      onPressed: controller.submit,
    );
  }

  Widget _buildToggleModeButton(AppLocalizations l10n) {
    return CustomTextButton(
      text: controller.isLoginMode
          ? l10n.noAccountQuestion
          : l10n.hasAccountQuestion,
      onPressed: controller.isSubmitting ? null : controller.toggleMode,
    );
  }
}
