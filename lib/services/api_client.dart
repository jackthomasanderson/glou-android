import 'package:http/http.dart' as http;
import 'dart:convert';

/// API Client for Glou Backend
class ApiClient {
  static const String baseUrl = 'http://localhost:8080';
  
  String? _token;

  ApiClient({String? token}) : _token = token;

  /// Generic request method
  Future<dynamic> request(
    String method,
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (_token != null) {
      requestHeaders['Authorization'] = 'Bearer $_token';
    }

    try {
      http.Response response;

      switch (method) {
        case 'GET':
          response = await http.get(url, headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(
            url,
            headers: requestHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: requestHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(url, headers: requestHeaders);
          break;
        default:
          throw Exception('Unknown method: $method');
      }

      if (response.statusCode >= 400) {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }

      if (response.statusCode == 204) {
        return null;
      }

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('API Error [$method $endpoint]: $e');
    }
  }

  // ============ WINES ============

  Future<List<Map<String, dynamic>>> getWines() async {
    final data = await request('GET', '/wines');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> getWineById(int id) async {
    return await request('GET', '/wines/$id');
  }

  Future<List<Map<String, dynamic>>> searchWines(Map<String, dynamic> filters) async {
    final params = _buildQueryParams(filters);
    final data = await request('GET', '/wines/search?$params');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> createWine(Map<String, dynamic> wine) async {
    return await request('POST', '/wines', data: wine);
  }

  Future<Map<String, dynamic>> updateWine(int id, Map<String, dynamic> wine) async {
    return await request('PUT', '/wines/$id', data: wine);
  }

  Future<void> deleteWine(int id) async {
    await request('DELETE', '/wines/$id');
  }

  Future<List<Map<String, dynamic>>> getWinesToDrinkNow() async {
    final data = await request('GET', '/wines/drinkable');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  // ============ CAVES ============

  Future<List<Map<String, dynamic>>> getCaves() async {
    final data = await request('GET', '/caves');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> createCave(Map<String, dynamic> cave) async {
    return await request('POST', '/caves', data: cave);
  }

  Future<List<Map<String, dynamic>>> getCells(int caveId) async {
    final data = await request('GET', '/caves/$caveId/cells');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> createCell(Map<String, dynamic> cell) async {
    return await request('POST', '/cells', data: cell);
  }

  // ============ ALERTS ============

  Future<List<Map<String, dynamic>>> getAlerts() async {
    final data = await request('GET', '/alerts');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> createAlert(Map<String, dynamic> alert) async {
    return await request('POST', '/alerts', data: alert);
  }

  Future<void> dismissAlert(int id) async {
    await request('DELETE', '/alerts/$id');
  }

  // ============ CONSUMPTION HISTORY ============

  Future<List<Map<String, dynamic>>> getConsumptionHistory(int wineId) async {
    final data = await request('GET', '/wines/$wineId/history');
    return List<Map<String, dynamic>>.from(data ?? []);
  }

  Future<Map<String, dynamic>> recordConsumption(
    Map<String, dynamic> consumption,
  ) async {
    return await request('POST', '/consumption', data: consumption);
  }

  // ============ SETTINGS ============

  Future<Map<String, dynamic>> getSettings() async {
    return await request('GET', '/api/admin/settings');
  }

  Future<Map<String, dynamic>> updateSettings(
    Map<String, dynamic> settings,
  ) async {
    return await request('PUT', '/api/admin/settings', data: settings);
  }

  // ============ HELPERS ============

  String _buildQueryParams(Map<String, dynamic> params) {
    final queryParams = <String>[];
    params.forEach((key, value) {
      if (value != null && value != '') {
        queryParams.add('$key=$value');
      }
    });
    return queryParams.join('&');
  }
}
