// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Glutton Budget';

  @override
  String get menu => 'Menu';

  @override
  String get home => 'Home';

  @override
  String get addDepense => 'Add expense';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get thisWeek => 'This week';

  @override
  String get thisMonth => 'This month';

  @override
  String get thisYear => 'This year';

  @override
  String get all => 'All';

  @override
  String get addMeal => 'Add a meal';

  @override
  String get infoBoursier => 'CROUS Meal: 1€ (scholarship)';

  @override
  String get infoNonBoursier => 'CROUS Meal: 3.30€ (non-scholarship)';

  @override
  String get customDepense => 'Custom expense';

  @override
  String get repasCrousBoursier => 'CROUS Meal (scholarship)';

  @override
  String get repasCrousNonBoursier => 'CROUS Meal (non-scholarship)';

  @override
  String get addDepenseTitle => 'Add an expense';

  @override
  String get errorInvalidInput => 'Please enter a valid title and amount';

  @override
  String get successDepenseAdded => 'Expense added successfully!';

  @override
  String get titreLabel => 'Title';

  @override
  String get titreHint => 'Title';

  @override
  String get descriptionLabel => 'Description:';

  @override
  String get descriptionHint => 'Enter a description here...';

  @override
  String get addImage => 'Add an image';

  @override
  String get addBtn => 'Add';

  @override
  String get noExpenses => 'No expenses yet';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get boursierLabel => 'Scholarship holder';

  @override
  String get isBoursier => 'Scholarship';

  @override
  String get isNotBoursier => 'No scholarship';

  @override
  String get darkModeLabel => 'Dark mode';

  @override
  String get darkModeSubtitle => 'Enable dark mode';

  @override
  String get colorLabel => 'App color';

  @override
  String get languageLabel => 'Language';
}
