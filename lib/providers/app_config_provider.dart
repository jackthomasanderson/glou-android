import 'package:flutter/material.dart';
import '../services/api_client.dart';

/// Provider pour gérer la configuration de l'application
/// Permet à l'admin de personnaliser le nom et le slogan de l'app
class AppConfigProvider with ChangeNotifier {
  final ApiClient apiClient;
  
  String _appName = 'Glou';
  String _appSlogan = 'Your personal cellar';
  bool _isLoading = false;
  String? _error;

  AppConfigProvider({required this.apiClient}) {
    _loadConfig();
  }

  String get appName => _appName;
  String get appSlogan => _appSlogan;
  String get appTitle => '$_appName: $_appSlogan';
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Charge la configuration depuis le serveur
  Future<void> _loadConfig() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final settings = await apiClient.getAdminSettings();
      
      _appName = settings['app_title'] as String? ?? 'Glou';
      _appSlogan = settings['app_slogan'] as String? ?? 'Your personal cellar';
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      // Garder les valeurs par défaut en cas d'erreur
      notifyListeners();
    }
  }

  /// Recharge la configuration (à appeler après modification côté admin)
  Future<void> reload() async {
    await _loadConfig();
  }
}
