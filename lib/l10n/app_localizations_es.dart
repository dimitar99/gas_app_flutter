// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get common_app_title => 'Gas App';

  @override
  String get common_error_message => 'Ha ocurrido un error';

  @override
  String get common_retry => 'Reintentar';

  @override
  String get auth_login_invalid_credentials => 'Credenciales inválidas';

  @override
  String get auth_welcome_back => 'Bienvenido de nuevo';

  @override
  String get auth_create_account_title => 'Crear una cuenta nueva';

  @override
  String get auth_no_account_link => '¿No tienes cuenta? Regístrate';

  @override
  String get auth_already_have_account_link => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get auth_button_processing => 'Procesando...';

  @override
  String get auth_button_login => 'Iniciar sesión';

  @override
  String get auth_button_register => 'Registrarse';

  @override
  String get email_label => 'Correo electrónico';

  @override
  String get email_hint => 'test@email.com';

  @override
  String get password_label => 'Contraseña';

  @override
  String get password_hint => '********';

  @override
  String get validator_required => 'Campo obligatorio';

  @override
  String get validator_email_empty => 'El email es obligatorio';

  @override
  String get validator_email_invalid => 'Email no válido';

  @override
  String get validator_password_empty => 'La contraseña es obligatoria';

  @override
  String get validator_password_length => 'Mínimo 6 caracteres';

  @override
  String get validator_password_empty_login => 'Por favor, ingrese su contraseña';

  @override
  String get preferences_optional_label => 'Preferencias (opcional)';

  @override
  String get preferred_fuel_type_label => 'Tipo de combustible preferido';

  @override
  String get select_fuel_hint => 'Seleccione un combustible';

  @override
  String get tank_capacity_label => 'Capacidad del depósito (litros)';

  @override
  String get search_radius_label => 'Radio de búsqueda (km)';

  @override
  String get unit_liters => 'litros';

  @override
  String get unit_km => 'km';

  @override
  String get gas_stations_page_title => 'Gasolineras';

  @override
  String get gas_station_detail_title => 'Detalle';

  @override
  String get gas_station_gasoline_95 => 'Gasolina 95';

  @override
  String get gas_station_gasoline_98 => 'Gasolina 98';

  @override
  String get gas_station_diesel_a => 'Diesel';

  @override
  String get gas_station_diesel_b => 'Diesel Premium';

  @override
  String get gas_station_adblue => 'AdBlue';

  @override
  String get gas_station_glp => 'GLP';

  @override
  String get gas_station_gnc => 'GNC';

  @override
  String get gas_station_schedule_title => 'Horario';

  @override
  String get gas_station_prices_title => 'Precios';

  @override
  String get gas_station_how_to_arrive => 'Como llegar';

  @override
  String get gas_station_address_title => 'Dirección';

  @override
  String get profile_title => 'Perfil';

  @override
  String get profile_preferences_section => 'Preferencias';

  @override
  String get profile_button_update => 'Actualizar';

  @override
  String get profile_button_logout => 'Cerrar sesión';

  @override
  String get profile_update_success => 'Preferencias actualizadas correctamente';
}
