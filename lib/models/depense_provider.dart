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
    _historique.insert(0, Depense(
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

  Future<void> remplirDonneesTest() async {
    final now = DateTime.now();

    _historique.clear();

    // Dépense d'aujourd'hui
    _historique.add(Depense(
      titre: "Repas",
      description: "Déjeuner CROUS (aujourd'hui)",
      montant: 1.0,
      date: now,
    ));

    // Dépense de la semaine dernière (il y a 5 jours)
    _historique.add(Depense(
      titre: "Courses",
      description: "Supermarché (semaine dernière)",
      montant: 45.50,
      date: now.subtract(const Duration(days: 5)),
    ));

    // Dépense du mois dernier (il y a 20 jours)
    _historique.add(Depense(
      titre: "Cinéma",
      description: "Sortie amis (mois dernier)",
      montant: 12.0,
      date: now.subtract(const Duration(days: 20)),
    ));

    // Dépense de l'an dernier (il y a 100 jours ou plus)
    _historique.add(Depense(
      titre: "Cadeau Noël",
      description: "Achat (année dernière)",
      montant: 25.0,
      date: DateTime(now.year - 1, 12, 25),
    ));

    notifyListeners();
    await _saveToPrefs();
  }
}

