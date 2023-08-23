import 'package:flutter/material.dart';

import '../presentation/helpers/localization_helper.dart';

class ValueValidators {
  static FormFieldValidator<String?> validateEmail(BuildContext context) {
    const patternEmail = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    return (value) {
      if (value!.isEmpty) {
        return tr(context).thisFieldIsEmpty;
      } else if (!checkPattern(pattern: patternEmail, value: value)) {
        return tr(context).pleaseEnterValidEmail;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validateLoginPassword(BuildContext context) {
    return (value) {
      if (value!.isEmpty) {
        return tr(context).thisFieldIsEmpty;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validateMobileNumber(BuildContext context) {
    const patternMobileNumber = r'^01[0125][0-9]{8}$';
    return (value) {
      value = value?.trim();
      if (value!.isEmpty) {
        return tr(context).thisFieldIsEmpty;
      } else if (!checkPattern(pattern: patternMobileNumber, value: value)) {
        return tr(context).pleaseEnterValidNumber;
      }
      return null;
    };
  }

  static FormFieldValidator<String?> validateName(BuildContext context) {
    //english name: r'^[a-zA-Z,.\-]+$'
    //arabic name: r'^[\u0621-\u064A\040]+$'
    //english and arabic names
    const patternName = r'^[\u0621-\u064A\040\a-zA-Z,.\-]+$';
    return (value) {
      if (value!.isEmpty) {
        return tr(context).thisFieldIsEmpty;
      } else if (value.length < 2) {
        return tr(context).nameMustBeAtLeast2Letters;
      } else if (value.length > 30) {
        return tr(context).nameMustBeAtMost30Letters;
      } else if (!checkPattern(pattern: patternName, value: value)) {
        return tr(context).pleaseEnterValidName;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validateEmptyField(BuildContext context) {
    return (value) {
      if (value!.isEmpty) {
        return tr(context).thisFieldIsEmpty;
      } else {
        return null;
      }
    };
  }

  static bool isNumeric(String str) {
    const patternInteger = r'^-?[0-9]+$';
    return checkPattern(pattern: patternInteger, value: str);
  }

  static bool isNumericPositive(String str) {
    const patternPositiveInteger = r'^[1-9]\d*$';
    return checkPattern(pattern: patternPositiveInteger, value: str);
  }

  static bool checkPattern({required String pattern, required String value}) {
    final regularCheck = RegExp(pattern);
    return regularCheck.hasMatch(value);
  }
}
