import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/others/input_validator.dart';

void main() {
  group("validateEmail", () {
    test("should return error, if input is empty", () {
      var result = InputValidator.validateEmail("");
      expect(result, "Enter a valid email address");
    });

    test("should return error, if input is not an email", () {
      var result = InputValidator.validateEmail("text");
      expect(result, "Enter a valid email address");
    });

    test("should return null, if input is valid", () {
      var result = InputValidator.validateEmail("abc@xyz.com");
      expect(result, null);
    });
  });

  group("validateContactNo", () {
    test("should return error, if input is empty", () {
      var result = InputValidator.validateContactNo("");
      expect(result, "Enter a valid contact number");
    });

    test("should return error, if input contains non-integers", () {
      var result = InputValidator.validateContactNo("011a");
      expect(result, "Enter a valid contact number");
    });

    test("should return error, if input donot contain 10 numbers", () {
      var result = InputValidator.validateContactNo("0112");
      expect(result, "Enter a valid contact number");
    });

    test("should return null, if input is valid", () {
      var result = InputValidator.validateContactNo("0112345678");
      expect(result, null);
    });
  });

  group("validateReason", () {
    test("should return error, if input is empty", () {
      var result = InputValidator.validateReason("");
      expect(result, "Enter the reason");
    });

    test("should return null, if input is valid", () {
      var result = InputValidator.validateReason("For a guest lecture");
      expect(result, null);
    });
  });
}
