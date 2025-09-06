import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/core/utils/extensions.dart';
import 'package:home_pause/core/utils/validators.dart';
import 'package:home_pause/data/services/auth_service.dart';
import 'package:home_pause/data/services/session_service.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';
import 'package:home_pause/views/components/text_field.component.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoSection(),
                  const SizedBox(height: AppDimensions.spacingLarge),
                  _buildTitleSection(),
                  const SizedBox(height: AppDimensions.spacingExtraLarge),
                  _buildFormSection(),
                  const SizedBox(height: AppDimensions.spacingExtraLarge),
                  _buildLoginButton(),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Image.asset(
        AppAssets.logo,
        width: AppDimensions.imageSmall,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitleSection() {
    return Text(
      AppStrings.loginTitle,
      style: AppTextStyles.titleMedium,
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: [
        CustomTextField(
          labelText: AppStrings.emailLabel,
          prefixIcon: Icons.email,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
        CustomTextField(
          labelText: AppStrings.passwordLabel,
          prefixIcon: Icons.lock,
          controller: _passwordController,
          isObscure: true,
          validator: _validatePassword,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomPrimaryButton(
      text: AppStrings.enterButton,
      onPressed: _isLoading ? null : _handleLogin,
      isLoading: _isLoading,
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.noAccountQuestion,
          textAlign: TextAlign.center,
          style: AppTextStyles.greyText,
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.register),
          child: Text(
            AppStrings.registerLink,
            textAlign: TextAlign.center,
            style: AppTextStyles.linkText,
          ),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    return AppValidators.email(value);
  }

  String? _validatePassword(String? value) {
    return AppValidators.password(value);
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userModel = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted && userModel != null) {
        await SessionService.saveUserSession(userModel.id);

        Navigator.pushReplacementNamed(context, AppRoutes.main);
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
