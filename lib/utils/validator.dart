String validatorRequired(value) {
  if (value.isEmpty) {
    return '';
  }
  return null;
}

String validatorEmail(value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);

  if (value.isEmpty || !emailValid) {
    return 'Wrong Email';
  }

  return null;
}
