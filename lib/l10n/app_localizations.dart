import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @common_app_title.
  ///
  /// In en, this message translates to:
  /// **'Gas App'**
  String get common_app_title;

  /// No description provided for @common_error_message.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred'**
  String get common_error_message;

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

  /// No description provided for @auth_login_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get auth_login_invalid_credentials;

  /// No description provided for @auth_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get auth_welcome_back;

  /// No description provided for @auth_create_account_title.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get auth_create_account_title;

  /// No description provided for @auth_no_account_link.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get auth_no_account_link;

  /// No description provided for @auth_already_have_account_link.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get auth_already_have_account_link;

  /// No description provided for @auth_button_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get auth_button_processing;

  /// No description provided for @auth_button_login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get auth_button_login;

  /// No description provided for @auth_button_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_button_register;

  /// No description provided for @email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_label;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'test@email.com'**
  String get email_hint;

  /// No description provided for @password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_label;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get password_hint;

  /// No description provided for @validator_required.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get validator_required;

  /// No description provided for @validator_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validator_email_empty;

  /// No description provided for @validator_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get validator_email_invalid;

  /// No description provided for @validator_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validator_password_empty;

  /// No description provided for @validator_password_length.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get validator_password_length;

  /// No description provided for @validator_password_empty_login.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validator_password_empty_login;

  /// No description provided for @preferences_optional_label.
  ///
  /// In en, this message translates to:
  /// **'Preferences (optional)'**
  String get preferences_optional_label;

  /// No description provided for @preferred_fuel_type_label.
  ///
  /// In en, this message translates to:
  /// **'Preferred fuel type'**
  String get preferred_fuel_type_label;

  /// No description provided for @select_fuel_hint.
  ///
  /// In en, this message translates to:
  /// **'Select a fuel'**
  String get select_fuel_hint;

  /// No description provided for @tank_capacity_label.
  ///
  /// In en, this message translates to:
  /// **'Tank capacity (liters)'**
  String get tank_capacity_label;

  /// No description provided for @search_radius_label.
  ///
  /// In en, this message translates to:
  /// **'Search radius (km)'**
  String get search_radius_label;

  /// No description provided for @unit_liters.
  ///
  /// In en, this message translates to:
  /// **'liters'**
  String get unit_liters;

  /// No description provided for @unit_km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unit_km;

  /// No description provided for @gas_stations_page_title.
  ///
  /// In en, this message translates to:
  /// **'Gas Stations'**
  String get gas_stations_page_title;

  /// No description provided for @gas_station_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get gas_station_detail_title;

  /// No description provided for @gas_station_gasoline_95.
  ///
  /// In en, this message translates to:
  /// **'Gasoline 95'**
  String get gas_station_gasoline_95;

  /// No description provided for @gas_station_gasoline_98.
  ///
  /// In en, this message translates to:
  /// **'Gasoline 98'**
  String get gas_station_gasoline_98;

  /// No description provided for @gas_station_diesel_a.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get gas_station_diesel_a;

  /// No description provided for @gas_station_diesel_b.
  ///
  /// In en, this message translates to:
  /// **'Premium Diesel'**
  String get gas_station_diesel_b;

  /// No description provided for @gas_station_adblue.
  ///
  /// In en, this message translates to:
  /// **'AdBlue'**
  String get gas_station_adblue;

  /// No description provided for @gas_station_glp.
  ///
  /// In en, this message translates to:
  /// **'LPG'**
  String get gas_station_glp;

  /// No description provided for @gas_station_gnc.
  ///
  /// In en, this message translates to:
  /// **'CNG'**
  String get gas_station_gnc;

  /// No description provided for @gas_station_schedule_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get gas_station_schedule_title;

  /// No description provided for @gas_station_prices_title.
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get gas_station_prices_title;

  /// No description provided for @gas_station_how_to_arrive.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get gas_station_how_to_arrive;

  /// No description provided for @gas_station_address_title.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get gas_station_address_title;

  /// No description provided for @gas_station_best_price.
  ///
  /// In en, this message translates to:
  /// **'Best price'**
  String get gas_station_best_price;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_preferences_section.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profile_preferences_section;

  /// No description provided for @profile_button_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get profile_button_update;

  /// No description provided for @profile_button_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_button_logout;

  /// No description provided for @profile_update_success.
  ///
  /// In en, this message translates to:
  /// **'Preferences updated successfully'**
  String get profile_update_success;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
