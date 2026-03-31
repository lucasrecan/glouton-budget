class Depense {
  final String titre;
  final String description;
  final double montant;

  @override
  String toString() {
    return 'Dépense - $titre : $description. Montant : $montant';
  }

Depense({required this.titre, required this.description, required this.montant});
}
