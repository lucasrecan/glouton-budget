class Depense {
  final String titre;
  final String description;
  final double montant;
  final DateTime date;

  Depense({
    required this.titre,
    required this.description,
    required this.montant,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'montant': montant,
        'date': date.toIso8601String(),
      };

  factory Depense.fromJson(Map<String, dynamic> json) => Depense(
        titre: json['titre'],
        description: json['description'],
        montant: (json['montant'] as num).toDouble(),
        date: DateTime.parse(json['date']),
      );

  @override
  String toString() {
    return 'Dépense - $titre : $description. Montant : $montant (le ${date.day}/${date.month})';
  }
}

