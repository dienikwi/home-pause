import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_colors.dart';
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

class EditarPerfilView extends StatefulWidget {
  const EditarPerfilView({super.key});

  @override
  State<EditarPerfilView> createState() => _EditarPerfilViewState();
}

class _EditarPerfilViewState extends State<EditarPerfilView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _authService.getCurrentUserData();
      if (mounted) {
        setState(() {
          _nameController.text = user?.nome ?? '';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _handleSaveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await _authService.updateUserName(_nameController.text.trim());

      if (mounted) {
        context.showSuccessSnackBar('Nome atualizado com sucesso!');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Erro ao atualizar nome: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _handleDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir conta'),
          content: const Text(
            'Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        _isDeleting = true;
      });

      try {
        await _authService.deleteAccount();
        await SessionService.clearUserSession();

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
          context.showSuccessSnackBar('Conta excluída com sucesso');
        }
      } catch (e) {
        if (mounted) {
          context.showErrorSnackBar('Erro ao excluir conta: ${e.toString()}');
        }
      } finally {
        if (mounted) {
          setState(() {
            _isDeleting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.surfaceWhite,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Editar Perfil',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spacingLarge),
                _buildEditNameSection(),
                const SizedBox(height: AppDimensions.spacingHuge),
                _buildSaveButton(),
                const SizedBox(height: AppDimensions.spacingExtraLarge),
                _buildDeleteSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditNameSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: AppDimensions.elevationLow,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Editar Nome',
            style: AppTextStyles.cardTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          CustomTextField(
            labelText: AppStrings.nameLabel,
            prefixIcon: Icons.person,
            controller: _nameController,
            validator: _validateName,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return CustomPrimaryButton(
      text: 'Salvar Alterações',
      onPressed: _isSaving ? null : _handleSaveChanges,
      isLoading: _isSaving,
    );
  }

  Widget _buildDeleteSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zona de Perigo',
            style: AppTextStyles.cardTitle.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          Text(
            'Excluir sua conta removerá permanentemente todos os seus dados. Esta ação não pode ser desfeita.',
            style: AppTextStyles.cardDescription.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          CustomPrimaryButton(
            text: 'Excluir Conta',
            onPressed: _isDeleting ? null : _handleDeleteAccount,
            isLoading: _isDeleting,
            backgroundColor: AppColors.error,
          ),
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    return AppValidators.name(value);
  }
}
