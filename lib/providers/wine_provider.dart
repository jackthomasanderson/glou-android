import 'package:flutter/material.dart';
import '../services/api_client.dart';

/// Wine Provider - Manages wine data state
class WineProvider extends ChangeNotifier {
  final ApiClient apiClient;

  List<Map<String, dynamic>> _wines = [];
  bool _loading = false;
  String? _error;

  WineProvider({required this.apiClient}) {
    fetchWines();
  }

  // Getters
  List<Map<String, dynamic>> get wines => _wines;
  bool get loading => _loading;
  String? get error => _error;

  /// Fetch all wines
  Future<void> fetchWines() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _wines = await apiClient.getWines();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Search wines with filters
  Future<void> searchWines(Map<String, dynamic> filters) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _wines = await apiClient.searchWines(filters);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Create wine
  Future<Map<String, dynamic>?> createWine(Map<String, dynamic> wine) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final newWine = await apiClient.createWine(wine);
      _wines.insert(0, newWine);
      notifyListeners();
      return newWine;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
    }
  }

  /// Update wine
  Future<Map<String, dynamic>?> updateWine(
    int id,
    Map<String, dynamic> wine,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await apiClient.updateWine(id, wine);
      final index = _wines.indexWhere((w) => w['id'] == id);
      if (index >= 0) {
        _wines[index] = updated;
      }
      notifyListeners();
      return updated;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
    }
  }

  /// Delete wine
  Future<void> deleteWine(int id) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await apiClient.deleteWine(id);
      _wines.removeWhere((w) => w['id'] == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
    }
  }

  /// Get wines to drink now
  Future<List<Map<String, dynamic>>> getWinesToDrinkNow() async {
    try {
      return await apiClient.getWinesToDrinkNow();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }
}

/// Alerts Provider
class AlertsProvider extends ChangeNotifier {
  final ApiClient apiClient;

  List<Map<String, dynamic>> _alerts = [];
  bool _loading = false;
  String? _error;

  AlertsProvider({required this.apiClient}) {
    fetchAlerts();
  }

  List<Map<String, dynamic>> get alerts => _alerts;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchAlerts() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _alerts = await apiClient.getAlerts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createAlert(Map<String, dynamic> alert) async {
    try {
      final newAlert = await apiClient.createAlert(alert);
      _alerts.insert(0, newAlert);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> dismissAlert(int id) async {
    try {
      await apiClient.dismissAlert(id);
      _alerts.removeWhere((a) => a['id'] == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}

/// Tasting History Provider
class TastingHistoryProvider extends ChangeNotifier {
  final ApiClient apiClient;
  final int wineId;

  List<Map<String, dynamic>> _history = [];
  bool _loading = false;
  String? _error;

  TastingHistoryProvider({required this.apiClient, required this.wineId}) {
    fetchHistory();
  }

  List<Map<String, dynamic>> get history => _history;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchHistory() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _history = await apiClient.getConsumptionHistory(wineId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> recordTasting(Map<String, dynamic> consumption) async {
    try {
      final record = await apiClient.recordConsumption(consumption);
      _history.insert(0, record);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
