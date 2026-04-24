import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get logo;

  /// No description provided for @website_name.
  ///
  /// In en, this message translates to:
  /// **'Modares'**
  String get website_name;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get login_title;

  /// No description provided for @login_loginDesc.
  ///
  /// In en, this message translates to:
  /// **'Log in to access your account and continue your lessons'**
  String get login_loginDesc;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email;

  /// No description provided for @login_emailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get login_emailError;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_remember.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get login_remember;

  /// No description provided for @login_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get login_forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_noAccount;

  /// No description provided for @login_createAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get login_createAccount;

  /// No description provided for @signup_title.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get signup_title;

  /// No description provided for @signup_description.
  ///
  /// In en, this message translates to:
  /// **'Join the largest educational community in the Arab world'**
  String get signup_description;

  /// No description provided for @signup_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get signup_name;

  /// No description provided for @signup_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signup_email;

  /// No description provided for @signup_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get signup_phone;

  /// No description provided for @signup_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signup_password;

  /// No description provided for @signup_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signup_confirmPassword;

  /// No description provided for @signup_create.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signup_create;

  /// No description provided for @signup_haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signup_haveAccount;

  /// No description provided for @signup_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get signup_login;

  /// No description provided for @signup_nameError.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 4 characters'**
  String get signup_nameError;

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailError;

  /// No description provided for @emailNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailNotCorrect;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordError;

  /// No description provided for @passwordNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Password is not correct'**
  String get passwordNotCorrect;

  /// No description provided for @confirmError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmError;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get name_required;

  /// No description provided for @confirm_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirm_password_required;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_not_match;

  /// No description provided for @phone_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phone_required;

  /// No description provided for @phone_invalid_egypt.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Egyptian phone number (11 digits starting with 01)'**
  String get phone_invalid_egypt;

  /// No description provided for @email_already_exists.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get email_already_exists;

  /// No description provided for @stage_primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get stage_primary;

  /// No description provided for @stage_preparatory.
  ///
  /// In en, this message translates to:
  /// **'Preparatory'**
  String get stage_preparatory;

  /// No description provided for @stage_secondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get stage_secondary;

  /// No description provided for @choose_stage.
  ///
  /// In en, this message translates to:
  /// **'Choose your grade'**
  String get choose_stage;

  /// No description provided for @stage_primary_1.
  ///
  /// In en, this message translates to:
  /// **'Primary 1'**
  String get stage_primary_1;

  /// No description provided for @stage_primary_2.
  ///
  /// In en, this message translates to:
  /// **'Primary 2'**
  String get stage_primary_2;

  /// No description provided for @stage_primary_3.
  ///
  /// In en, this message translates to:
  /// **'Primary 3'**
  String get stage_primary_3;

  /// No description provided for @stage_primary_4.
  ///
  /// In en, this message translates to:
  /// **'Primary 4'**
  String get stage_primary_4;

  /// No description provided for @stage_primary_5.
  ///
  /// In en, this message translates to:
  /// **'Primary 5'**
  String get stage_primary_5;

  /// No description provided for @stage_primary_6.
  ///
  /// In en, this message translates to:
  /// **'Primary 6'**
  String get stage_primary_6;

  /// No description provided for @stage_preparatory_1.
  ///
  /// In en, this message translates to:
  /// **'Preparatory 1'**
  String get stage_preparatory_1;

  /// No description provided for @stage_preparatory_2.
  ///
  /// In en, this message translates to:
  /// **'Preparatory 2'**
  String get stage_preparatory_2;

  /// No description provided for @stage_preparatory_3.
  ///
  /// In en, this message translates to:
  /// **'Preparatory 3'**
  String get stage_preparatory_3;

  /// No description provided for @stage_secondary_1.
  ///
  /// In en, this message translates to:
  /// **'Secondary 1'**
  String get stage_secondary_1;

  /// No description provided for @stage_secondary_2.
  ///
  /// In en, this message translates to:
  /// **'Secondary 2'**
  String get stage_secondary_2;

  /// No description provided for @stage_secondary_3.
  ///
  /// In en, this message translates to:
  /// **'Secondary 3'**
  String get stage_secondary_3;

  /// No description provided for @stage_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter your academic year'**
  String get stage_error;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @exploreTeachers.
  ///
  /// In en, this message translates to:
  /// **'Explore Teachers'**
  String get exploreTeachers;

  /// No description provided for @exploreCourses.
  ///
  /// In en, this message translates to:
  /// **'Explore Courses'**
  String get exploreCourses;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @ongoingCourses.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Courses'**
  String get ongoingCourses;

  /// No description provided for @trackProgress.
  ///
  /// In en, this message translates to:
  /// **'Track your learning progress'**
  String get trackProgress;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @searchTeacherNameHint.
  ///
  /// In en, this message translates to:
  /// **'Search by Teacher Name'**
  String get searchTeacherNameHint;

  /// No description provided for @noMatchFound.
  ///
  /// In en, this message translates to:
  /// **'Sorry No Match Found'**
  String get noMatchFound;

  /// No description provided for @welcomeHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcomeHeaderTitle(Object name);

  /// No description provided for @welcomeHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Hours a day thanks to educational tracking'**
  String get welcomeHeaderDescription;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @mathematics.
  ///
  /// In en, this message translates to:
  /// **'Mathematics'**
  String get mathematics;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @socialStudies.
  ///
  /// In en, this message translates to:
  /// **'Social Studies'**
  String get socialStudies;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @physics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get physics;

  /// No description provided for @chemistry.
  ///
  /// In en, this message translates to:
  /// **'Chemistry'**
  String get chemistry;

  /// No description provided for @biology.
  ///
  /// In en, this message translates to:
  /// **'Biology'**
  String get biology;

  /// No description provided for @pureMathematics.
  ///
  /// In en, this message translates to:
  /// **'Pure Mathematics'**
  String get pureMathematics;

  /// No description provided for @appliedMathematics.
  ///
  /// In en, this message translates to:
  /// **'Applied Mathematics'**
  String get appliedMathematics;

  /// No description provided for @philosophy.
  ///
  /// In en, this message translates to:
  /// **'Philosophy'**
  String get philosophy;

  /// No description provided for @psychology.
  ///
  /// In en, this message translates to:
  /// **'Psychology'**
  String get psychology;

  /// No description provided for @geography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get geography;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there are currently no enrolled courses'**
  String get noCoursesTitle;

  /// No description provided for @noCoursesDescription.
  ///
  /// In en, this message translates to:
  /// **'It looks like you have not started your learning journey with us yet. Explore our wide range of curricula and outstanding teachers, and start learning now!'**
  String get noCoursesDescription;

  /// No description provided for @noCoursesBrowseButton.
  ///
  /// In en, this message translates to:
  /// **'Browse Courses and Curricula'**
  String get noCoursesBrowseButton;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Scholar'**
  String get welcome;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'Your academic journey continues here.'**
  String get desc;

  /// No description provided for @subjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Units'**
  String get units;

  /// No description provided for @governorate_cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get governorate_cairo;

  /// No description provided for @governorate_alexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get governorate_alexandria;

  /// No description provided for @governorate_portSaid.
  ///
  /// In en, this message translates to:
  /// **'Port Said'**
  String get governorate_portSaid;

  /// No description provided for @governorate_suez.
  ///
  /// In en, this message translates to:
  /// **'Suez'**
  String get governorate_suez;

  /// No description provided for @governorate_beheira.
  ///
  /// In en, this message translates to:
  /// **'Beheira'**
  String get governorate_beheira;

  /// No description provided for @governorate_daqahliya.
  ///
  /// In en, this message translates to:
  /// **'Daqahliya'**
  String get governorate_daqahliya;

  /// No description provided for @governorate_damietta.
  ///
  /// In en, this message translates to:
  /// **'Damietta'**
  String get governorate_damietta;

  /// No description provided for @governorate_gharbiya.
  ///
  /// In en, this message translates to:
  /// **'Gharbiya'**
  String get governorate_gharbiya;

  /// No description provided for @governorate_kafrElSheikh.
  ///
  /// In en, this message translates to:
  /// **'Kafr El Sheikh'**
  String get governorate_kafrElSheikh;

  /// No description provided for @governorate_monufia.
  ///
  /// In en, this message translates to:
  /// **'Monufia'**
  String get governorate_monufia;

  /// No description provided for @governorate_qalyubia.
  ///
  /// In en, this message translates to:
  /// **'Qalyubia'**
  String get governorate_qalyubia;

  /// No description provided for @governorate_sharqiya.
  ///
  /// In en, this message translates to:
  /// **'Sharqiya'**
  String get governorate_sharqiya;

  /// No description provided for @governorate_ismailia.
  ///
  /// In en, this message translates to:
  /// **'Ismailia'**
  String get governorate_ismailia;

  /// No description provided for @governorate_asyut.
  ///
  /// In en, this message translates to:
  /// **'Asyut'**
  String get governorate_asyut;

  /// No description provided for @governorate_aswan.
  ///
  /// In en, this message translates to:
  /// **'Aswan'**
  String get governorate_aswan;

  /// No description provided for @governorate_beniSuef.
  ///
  /// In en, this message translates to:
  /// **'Beni Suef'**
  String get governorate_beniSuef;

  /// No description provided for @governorate_fayoum.
  ///
  /// In en, this message translates to:
  /// **'Fayoum'**
  String get governorate_fayoum;

  /// No description provided for @governorate_giza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get governorate_giza;

  /// No description provided for @governorate_luxor.
  ///
  /// In en, this message translates to:
  /// **'Luxor'**
  String get governorate_luxor;

  /// No description provided for @governorate_minya.
  ///
  /// In en, this message translates to:
  /// **'Minya'**
  String get governorate_minya;

  /// No description provided for @governorate_qena.
  ///
  /// In en, this message translates to:
  /// **'Qena'**
  String get governorate_qena;

  /// No description provided for @governorate_sohag.
  ///
  /// In en, this message translates to:
  /// **'Sohag'**
  String get governorate_sohag;

  /// No description provided for @governorate_matrouh.
  ///
  /// In en, this message translates to:
  /// **'Matrouh'**
  String get governorate_matrouh;

  /// No description provided for @governorate_newValley.
  ///
  /// In en, this message translates to:
  /// **'New Valley'**
  String get governorate_newValley;

  /// No description provided for @governorate_redSea.
  ///
  /// In en, this message translates to:
  /// **'Red Sea'**
  String get governorate_redSea;

  /// No description provided for @governorate_northSinai.
  ///
  /// In en, this message translates to:
  /// **'North Sinai'**
  String get governorate_northSinai;

  /// No description provided for @governorate_southSinai.
  ///
  /// In en, this message translates to:
  /// **'South Sinai'**
  String get governorate_southSinai;

  /// No description provided for @filterDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter results'**
  String get filterDialogTitle;

  /// No description provided for @filterDialogReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filterDialogReset;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @chooseGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Choose governorate'**
  String get chooseGovernorate;

  /// No description provided for @teachingMethod.
  ///
  /// In en, this message translates to:
  /// **'Teaching method'**
  String get teachingMethod;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top rated'**
  String get topRated;

  /// No description provided for @priceHigh.
  ///
  /// In en, this message translates to:
  /// **'Price high'**
  String get priceHigh;

  /// No description provided for @priceLow.
  ///
  /// In en, this message translates to:
  /// **'Price low'**
  String get priceLow;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @profileButton.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileButton;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
