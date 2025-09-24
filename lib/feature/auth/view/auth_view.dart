import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                    ],
                    const SizedBox(height: 30),
                    _buildSubmitButton(),
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
          'Konta\nGestão financeira',
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
          controller.isLoginMode ? 'Entre na sua conta' : 'Crie uma nova conta',
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
        labelText: 'E-mail',
        hintText: 'Digite seu e-mail',
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
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Confirmar senha',
        hintText: 'Digite novamente sua senha',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: controller.toggleObscurePassword,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: controller.validateConfirmPassword,
    );
  }

  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      text: controller.isLoginMode
          ? 'Entrar'
          : 'Cadastrar',
      isSubmitting: controller.isSubmitting,
      onPressed: controller.submit,
    );
  }

  Widget _buildToggleModeButton() {
    return CustomTextButton(
      text: controller.isLoginMode
          ? 'Não tem uma conta? Cadastre-se!'
          : 'Já tem uma conta? Entre aqui!',
      onPressed: controller.isSubmitting ? null : controller.toggleMode,
    );
  }
}
