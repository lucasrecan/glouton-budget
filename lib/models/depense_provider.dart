import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'depense.dart';

class DepenseProvider extends ChangeNotifier {
  List<Depense> _historique = [];

  List<Depense> get historique => _historique;

  DepenseProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('depenses');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _historique = decoded.map((item) => Depense.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_historique.map((e) => e.toJson()).toList());
    await prefs.setString('depenses', encoded);
  }

  Future<void> ajouterDepense({
    required String titre,
    required String description,
    required double montant,
    DateTime? date,
  }) async {
    _historique.add(Depense(
      titre: titre,
      description: description,
      montant: montant,
      date: date ?? DateTime.now(),
    ));
    notifyListeners();
    await _saveToPrefs();
  }

  Future<void> supprimerDepense(int index) async {
    _historique.removeAt(index);
    notifyListeners();
    await _saveToPrefs();
  }
}
