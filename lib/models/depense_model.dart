import 'package:flutter/material.dart';
import 'depense.dart';

class IMCModel extends ChangeNotifier {
  final List<Depense> _historique = [];

  List<Depense> get historique => _historique;

  void ajouterDepense({
    required String titre,
    required String description,
    required double montant,
  }) {
    _historique.add(Depense(titre: titre, description: description, montant: montant));
    notifyListeners();
  }

  void supprimerDepense(int index) {
    _historique.removeAt(index);
    notifyListeners();
  }
}