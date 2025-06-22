import 'package:flutter/material.dart';

import 'package:main/l10n/app_localizations.dart';

class FormValidators {
  static String? emailValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validationEmailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return AppLocalizations.of(context)!.validationEmailInvalid;
    }
    return null;
  }

  static String? passwordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validationPasswordRequired;
    }
    return null;
  }

  static String? confirmPasswordValidator(
    BuildContext context,
    String? value,
    String? password,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validationConfirmPasswordRequired;
    }
    if (value != password) {
      return AppLocalizations.of(context)!.validationPasswordsDoNotMatch;
    }
    return null;
  }
}
