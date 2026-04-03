// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_app_title => 'Gas App';

  @override
  String get common_error_message => 'An error has occurred';

  @override
  String get common_retry => 'Retry';

  @override
  String get auth_login_invalid_credentials => 'Invalid credentials';

  @override
  String get auth_welcome_back => 'Welcome back';

  @override
  String get auth_create_account_title => 'Create a new account';

  @override
  String get auth_no_account_link => 'Don\'t have an account? Sign up';

  @override
  String get auth_already_have_account_link => 'Already have an account? Log in';

  @override
  String get auth_button_processing => 'Processing...';

  @override
  String get auth_button_login => 'Log in';

  @override
  String get auth_button_register => 'Register';

  @override
  String get email_label => 'Email';

  @override
  String get email_hint => 'test@email.com';

  @override
  String get password_label => 'Password';

  @override
  String get password_hint => '********';

  @override
  String get validator_required => 'Required field';

  @override
  String get validator_email_empty => 'Email is required';

  @override
  String get validator_email_invalid => 'Invalid email';

  @override
  String get validator_password_empty => 'Password is required';

  @override
  String get validator_password_length => 'Minimum 6 characters';

  @override
  String get validator_password_empty_login => 'Please enter your password';

  @override
  String get preferences_optional_label => 'Preferences (optional)';

  @override
  String get preferred_fuel_type_label => 'Preferred fuel type';

  @override
  String get select_fuel_hint => 'Select a fuel';

  @override
  String get tank_capacity_label => 'Tank capacity (liters)';

  @override
  String get search_radius_label => 'Search radius (km)';

  @override
  String get unit_liters => 'liters';

  @override
  String get unit_km => 'km';

  @override
  String get gas_stations_page_title => 'Gas Stations';

  @override
  String get gas_station_detail_title => 'Details';

  @override
  String get gas_station_gasoline_95 => 'Gasoline 95';

  @override
  String get gas_station_gasoline_98 => 'Gasoline 98';

  @override
  String get gas_station_diesel_a => 'Diesel';

  @override
  String get gas_station_diesel_b => 'Premium Diesel';

  @override
  String get gas_station_adblue => 'AdBlue';

  @override
  String get gas_station_glp => 'LPG';

  @override
  String get gas_station_gnc => 'CNG';

  @override
  String get gas_station_schedule_title => 'Schedule';

  @override
  String get gas_station_prices_title => 'Prices';

  @override
  String get gas_station_how_to_arrive => 'Get directions';

  @override
  String get gas_station_address_title => 'Address';

  @override
  String get gas_station_best_price => 'Best price';

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_preferences_section => 'Preferences';

  @override
  String get profile_button_update => 'Update';

  @override
  String get profile_button_logout => 'Log out';

  @override
  String get profile_update_success => 'Preferences updated successfully';
}
