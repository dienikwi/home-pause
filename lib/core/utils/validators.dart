class AppValidators {
  AppValidators._();

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira ${fieldName ?? 'este campo'}';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }

    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }

    if (value.length < minLength) {
      return 'A senha deve ter pelo menos $minLength caracteres';
    }

    return null;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }

    if (value != originalPassword) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  static String? name(String? value, {int minLength = 2}) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira seu nome';
    }

    if (value.trim().length < minLength) {
      return 'O nome deve ter pelo menos $minLength caracteres';
    }

    return null;
  }

  static String? number(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira ${fieldName ?? 'um número'}';
    }

    if (double.tryParse(value) == null) {
      return 'Por favor, insira um número válido';
    }

    return null;
  }

  static String? minAge(String? value, int minimumAge) {
    final numberError = number(value, fieldName: 'sua idade');
    if (numberError != null) return numberError;

    final age = int.parse(value!);
    if (age < minimumAge) {
      return 'Idade mínima: $minimumAge anos';
    }

    return null;
  }

  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
