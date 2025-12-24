import 'package:flutter/material.dart';

/// Generated localization class - Generated from l10n/*.arb files
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? _instance;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('fr'),
  ];

  // Translation keys
  String get appTitle =>
      locale.languageCode == 'fr'
          ? 'Glou - Gestion de Cave à Vin'
          : 'Glou - Wine Cellar Management';

  String get dashboard =>
      locale.languageCode == 'fr' ? 'Tableau de bord' : 'Dashboard';

  String get wines => locale.languageCode == 'fr' ? 'Vins' : 'Wines';

  String get myCollection =>
      locale.languageCode == 'fr' ? '🍾 Ma Collection' : '🍾 My Collection';

  String get totalSales =>
      locale.languageCode == 'fr' ? 'Ventes Totales' : 'Total Sales';

  String get bottles =>
      locale.languageCode == 'fr' ? 'bouteilles' : 'bottles';

  String get revenue =>
      locale.languageCode == 'fr' ? 'Revenu' : 'Revenue';

  String get vsLastMonth =>
      locale.languageCode == 'fr' ? 'vs mois dernier' : 'vs last month';

  String get createCellarButton =>
      locale.languageCode == 'fr' ? 'Créer une cave' : 'Create a Cellar';

  String get yourDashboard =>
      locale.languageCode == 'fr'
          ? 'Votre tableau de bord'
          : 'Your Dashboard';

  String get mustCreateCellarDashboard =>
      locale.languageCode == 'fr'
          ? 'Vous devez d\'abord créer au moins une cave pour accéder au tableau de bord et voir vos statistiques.'
          : 'You must first create at least one cellar to access the dashboard and view your statistics.';

  String get mustCreateCellarWines =>
      locale.languageCode == 'fr'
          ? 'Vous devez d\'abord créer au moins une cave avant d\'ajouter des bouteilles à votre collection.'
          : 'You must first create at least one cellar before adding bottles to your collection.';

  String get createWineCollection =>
      locale.languageCode == 'fr'
          ? 'Créer une cave à vin'
          : 'Create a wine collection';

  String get consultWines =>
      locale.languageCode == 'fr'
          ? 'Consultez toutes vos bouteilles, recherchez, et filtrez par type. Cliquez sur une bouteille pour voir les détails.'
          : 'View all your bottles, search, and filter by type. Click on a bottle to see the details.';

  String get edit =>
      locale.languageCode == 'fr'
          ? 'Modifier cette bouteille'
          : 'Edit this bottle';

  String get delete =>
      locale.languageCode == 'fr'
          ? 'Supprimer cette bouteille'
          : 'Delete this bottle';

  String get loading =>
      locale.languageCode == 'fr' ? 'Chargement...' : 'Loading...';

  String get unknown =>
      locale.languageCode == 'fr' ? 'Inconnu' : 'Unknown';

  String get identification =>
      locale.languageCode == 'fr' ? 'Identification' : 'Identification';

  String get stock => locale.languageCode == 'fr' ? 'Stock' : 'Stock';

  String get apogeeWindow =>
      locale.languageCode == 'fr'
          ? 'Fenêtre d\'Apogée'
          : 'Apogee Window';

  String get evaluation =>
      locale.languageCode == 'fr' ? 'Évaluation' : 'Evaluation';

  String get comments =>
      locale.languageCode == 'fr' ? 'Commentaires' : 'Comments';

  String get vintage =>
      locale.languageCode == 'fr' ? 'Millésime' : 'Vintage';

  String get type => locale.languageCode == 'fr' ? 'Type' : 'Type';

  String get region => locale.languageCode == 'fr' ? 'Région' : 'Region';

  String get producer =>
      locale.languageCode == 'fr' ? 'Producteur' : 'Producer';

  String get quantity =>
      locale.languageCode == 'fr' ? 'Quantité' : 'Quantity';

  String get unitPrice =>
      locale.languageCode == 'fr' ? 'Prix Unitaire' : 'Unit Price';

  String get purchaseDate =>
      locale.languageCode == 'fr' ? 'Date d\'Achat' : 'Purchase Date';

  String get notes => locale.languageCode == 'fr' ? 'Remarques' : 'Notes';

  String get addWine =>
      locale.languageCode == 'fr' ? 'Ajouter un Vin' : 'Add Wine';

  String get searchWines =>
      locale.languageCode == 'fr' ? 'Chercher des vins...' : 'Search wines...';

  String get filterByType =>
      locale.languageCode == 'fr' ? 'Filtrer par type' : 'Filter by type';

  String get filterByRegion =>
      locale.languageCode == 'fr' ? 'Filtrer par région' : 'Filter by region';

  String get noWinesFound =>
      locale.languageCode == 'fr' ? 'Aucun vin trouvé' : 'No wines found';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
