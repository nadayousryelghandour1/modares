// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_title => 'Welcome back';

  @override
  String get login_loginDesc => 'Log in to access your account and continue your lessons';

  @override
  String get login_email => 'Email';

  @override
  String get login_emailError => 'Please enter a valid email';

  @override
  String get login_password => 'Password';

  @override
  String get login_remember => 'Remember me';

  @override
  String get login_forgotPassword => 'Forgot password?';

  @override
  String get login => 'Login';

  @override
  String get login_noAccount => 'Don\'t have an account?';

  @override
  String get login_createAccount => 'Sign Up';

  @override
  String get signup_title => 'Create New Account';

  @override
  String get signup_description => 'Join the largest educational community in the Arab world';

  @override
  String get signup_name => 'Full Name';

  @override
  String get signup_email => 'Email';

  @override
  String get signup_phone => 'Phone Number';

  @override
  String get signup_password => 'Password';

  @override
  String get signup_confirmPassword => 'Confirm Password';

  @override
  String get signup_create => 'Create Account';

  @override
  String get signup_haveAccount => 'Already have an account?';

  @override
  String get signup_login => 'Login';

  @override
  String get signup_nameError => 'Name must be at least 4 characters';

  @override
  String get emailError => 'Please enter a valid email';

  @override
  String get emailNotCorrect => 'Please enter a valid email';

  @override
  String get passwordError => 'Password must be at least 8 characters';

  @override
  String get passwordNotCorrect => 'Password is not correct';

  @override
  String get confirmError => 'Passwords do not match';

  @override
  String get name_required => 'Please enter your name';

  @override
  String get confirm_password_required => 'Please confirm your password';

  @override
  String get password_not_match => 'Passwords do not match';

  @override
  String get phone_required => 'Please enter your phone number';

  @override
  String get phone_invalid_egypt => 'Please enter a valid Egyptian phone number (11 digits starting with 01)';

  @override
  String get email_already_exists => 'This email is already registered';

  @override
  String get stage_primary => 'Primary';

  @override
  String get stage_preparatory => 'Preparatory';

  @override
  String get stage_secondary => 'Secondary';

  @override
  String get choose_stage => 'Choose your grade';

  @override
  String get stage_primary_1 => 'Primary 1';

  @override
  String get stage_primary_2 => 'Primary 2';

  @override
  String get stage_primary_3 => 'Primary 3';

  @override
  String get stage_primary_4 => 'Primary 4';

  @override
  String get stage_primary_5 => 'Primary 5';

  @override
  String get stage_primary_6 => 'Primary 6';

  @override
  String get stage_preparatory_1 => 'Preparatory 1';

  @override
  String get stage_preparatory_2 => 'Preparatory 2';

  @override
  String get stage_preparatory_3 => 'Preparatory 3';

  @override
  String get stage_secondary_1 => 'Secondary 1';

  @override
  String get stage_secondary_2 => 'Secondary 2';

  @override
  String get stage_secondary_3 => 'Secondary 3';

  @override
  String get stage_error => 'Please enter your academic year';
}
