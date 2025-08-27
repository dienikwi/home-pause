import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/core/utils/extensions.dart';
import 'package:home_pause/core/utils/validators.dart';
import 'package:home_pause/data/services/auth_service.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';
import 'package:home_pause/views/components/text_field.component.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                  _buildRegisterButton(),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  _buildLoginLink(),
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
      AppStrings.registerTitle,
      style: AppTextStyles.titleMedium,
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: [
        CustomTextField(
          labelText: AppStrings.nameLabel,
          prefixIcon: Icons.person,
          controller: _nameController,
          keyboardType: TextInputType.name,
          validator: _validateName,
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
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
        const SizedBox(height: AppDimensions.spacingLarge),
        CustomTextField(
          labelText: AppStrings.confirmPasswordLabel,
          prefixIcon: Icons.lock,
          controller: _confirmPasswordController,
          isObscure: true,
          validator: _validateConfirmPassword,
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return CustomPrimaryButton(
      text: AppStrings.registerActionButton,
      onPressed: _isLoading ? null : _handleRegister,
      isLoading: _isLoading,
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.hasAccountQuestion,
          textAlign: TextAlign.center,
          style: AppTextStyles.greyText,
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
          child: Text(
            AppStrings.loginLink,
            textAlign: TextAlign.center,
            style: AppTextStyles.linkText,
          ),
        ),
      ],
    );
  }

  String? _validateName(String? value) {
    return AppValidators.name(value);
  }

  String? _validateEmail(String? value) {
    return AppValidators.email(value);
  }

  String? _validatePassword(String? value) {
    return AppValidators.password(value);
  }

  String? _validateConfirmPassword(String? value) {
    return AppValidators.confirmPassword(value, _passwordController.text);
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userModel = await _authService.createAccount(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        nome: _nameController.text.trim(),
      );

      if (mounted && userModel != null) {
        context.showSuccessSnackBar('Cadastro realizado com sucesso!');
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        if (mounted) {
          context.showErrorSnackBar('Erro: Dados do usuário não foram criados');
        }
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
