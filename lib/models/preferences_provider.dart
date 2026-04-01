import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isBoursier = false;
  bool _isDarkMode = true;
  int _selectedColor = Colors.purple.toARGB32();
  String _selectedLanguage = 'fr';

  // Getters
  bool get isBoursier => _isBoursier;
  bool get isDarkMode => _isDarkMode;
  int get selectedColor => _selectedColor;
  String get selectedLanguage => _selectedLanguage;

  PreferencesProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isBoursier = prefs.getBool('isBoursier') ?? false;
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _selectedColor = prefs.getInt('selectedColor') ?? Colors.purple.value;
    _selectedLanguage = prefs.getString('selectedLanguage') ?? 'fr';
    notifyListeners();
  }

  // setters
  Future<void> setBoursier(bool value) async {
    _isBoursier = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBoursier', value);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setSelectedColor(int value) async {
    _selectedColor = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', value);
    notifyListeners();
  }

  Future<void> setSelectedLanguage(String value) async {
    _selectedLanguage = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', value);
    notifyListeners();
  }
}