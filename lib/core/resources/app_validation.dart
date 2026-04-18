// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:modares/l10n/app_localizations.dart';

class AppValidation {
  static String? email(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.emailError;
    }

    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.passwordError;
    }
    if (value.length < 2) {
      return AppLocalizations.of(context)!.passwordError;
    }

    return null;
  }

  static String? name(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.name_required;
    }
    if (value.length < 4) {
      return AppLocalizations.of(context)!.signup_nameError;
    }

    return null;
  }

  static String? confirmPassword(
    BuildContext context,
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.confirm_password_required;
    }

    if (value != password) {
      return AppLocalizations.of(context)!.password_not_match;
    }

    return null;
  }

  static String? phone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.phone_required;
    }

    final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');

    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.phone_invalid_egypt;
    }

    return null;
  }
}
