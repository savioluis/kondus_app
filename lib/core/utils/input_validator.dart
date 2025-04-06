class InputValidator {
  static bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) return false;

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return regex.hasMatch(value);
  }

  static bool isValidPassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return false;

    return value.length >= minLength;
  }

  static bool isValidPhone(String? value, {int maxLength = 14}) {
    if (value == null || value.isEmpty || value.length > maxLength) return false;

    const pattern = r'^\+?[1-9]\d{1,14}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(value);
  }

  static bool isValidUrl(String? value) {
    if (value == null || value.isEmpty) return false;

    const pattern = r'^(https?:\/\/)?([\w\d\-_]+(\.[\w\d\-_]+)+)([\w\d\-\.,@?^=%&:\/~\+#]*)?$';
    final regex = RegExp(pattern);

    return regex.hasMatch(value);
  }

  static String? validateName({required String name}) {
    if (name.isEmpty) return 'O nome é obrigatório';
    if (name.length < 2) return 'Nome inválido';
    return null;
  }

  static String? validateEmail({required String email}) {
    if (email.isEmpty) return 'O email é obrigatório';
    if (!isValidEmail(email)) return 'Email inválido';
    return null;
  }

  static String? validatePasswordOnly({required String password}) {
    if (password.isEmpty) return 'A senha é obrigatória.';
    if (password.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
    return null;
  }

  static String? validatePasswordWithConfirmPassword({
    required String password,
    required String passwordConfirmation,
  }) {
    if (password.isEmpty) return 'A senha é obrigatória.';
    if (password.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
    if (password != passwordConfirmation) return 'As senhas não coincidem.';
    return null;
  }
}