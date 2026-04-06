// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Glouton Budget';

  @override
  String get menu => 'Menu';

  @override
  String get home => 'Menu';

  @override
  String get addDepense => 'Ajouter dépense';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get thisMonth => 'Ce mois';

  @override
  String get thisYear => 'Cette année';

  @override
  String get all => 'Tout';

  @override
  String get addMeal => 'Ajouter un repas';

  @override
  String get customDepense => 'Dépense personnalisée';

  @override
  String get infoBoursier => 'Repas CROUS : 1€ (boursier)';

  @override
  String get infoNonBoursier => 'Repas CROUS : 3.30€ (non boursier)';

  @override
  String get noDepenses => 'Aucune dépense pour le moment';

  @override
  String get title => 'Titre';

  @override
  String get description => 'Description';

  @override
  String get amountHint => '0,00';

  @override
  String get descriptionHint => 'Mettre une description ici...';

  @override
  String get addImage => 'Ajouter une image';

  @override
  String get validateAdd => 'Ajouter';

  @override
  String get errorFields => 'Veuillez entrer un titre et un montant valide';

  @override
  String get successAdd => 'Dépense ajoutée avec succès !';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get enableDarkMode => 'Activer le thème sombre';

  @override
  String get studentStatus => 'Statut étudiant';

  @override
  String get boursier => 'Boursier';

  @override
  String get nonBoursier => 'Non boursier';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get mainColor => 'Couleur principale';

  @override
  String get repasCrousBoursier => 'Repas CROUS (boursier)';

  @override
  String get repasCrousNonBoursier => 'Repas CROUS (non boursier)';
}
