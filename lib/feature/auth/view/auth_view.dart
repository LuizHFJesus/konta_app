import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
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
          child: Form(
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
                  const SizedBox(height: 30),
                  _buildSubmitButton()
                ],
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
        const Text(
          'Entre na sua conta',
          style: TextStyle(fontSize: 18),
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
    return Obx(
      () => TextFormField(
        controller: controller.passwordController,
        obscureText: controller.obscurePassword,
        textInputAction: TextInputAction.done,
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
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(
      () => CustomElevatedButton(
        text: 'Entrar',
        isSubmitting: controller.isSubmitting,
        onPressed: controller.submit,
      ),
    );
  }
}
