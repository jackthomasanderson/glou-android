import 'package:flutter/material.dart';
import '../services/api_client.dart';

/// Cellar Provider - Manages cellar data state and checks for cellar existence
class CellarProvider extends ChangeNotifier {
  final ApiClient apiClient;

  List<Map<String, dynamic>> _cellars = [];
  bool _loading = false;
  String? _error;
  bool _hasCellar = false;

  CellarProvider({required this.apiClient}) {
    fetchCellars();
  }

  // Getters
  List<Map<String, dynamic>> get cellars => _cellars;
  bool get loading => _loading;
  String? get error => _error;
  bool get hasCellar => _hasCellar;

  /// Fetch all cellars
  Future<void> fetchCellars() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _cellars = await apiClient.getCaves();
      _hasCellar = _cellars.isNotEmpty;
    } catch (e) {
      _error = e.toString();
      _hasCellar = false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Create cellar
  Future<Map<String, dynamic>?> createCellar(
    Map<String, dynamic> cellar,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final newCellar = await apiClient.createCave(cellar);
      _cellars.insert(0, newCellar);
      _hasCellar = true;
      notifyListeners();
      return newCellar;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
    }
  }
}
