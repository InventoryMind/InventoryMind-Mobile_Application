class InputValidator {
  static String? validateEmail(String? val) {
    if ((val!.isEmpty) ||
        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(val)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validateContactNo(String? val) {
    if ((val!.isEmpty) ||
        !RegExp(r"^(\d+)*$").hasMatch(val) ||
        (val.length != 10)) {
      return "Enter a valid contact number";
    }
    return null;
  }

  static String? validateReason(String? val) {
    if (val!.isEmpty) {
      return "Enter the reason";
    }
    return null;
  }
}
