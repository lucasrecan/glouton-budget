import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/depense_model.dart';
import 'barre_navigation.dart';

class AjouterDepense extends StatefulWidget {
  const AjouterDepense({super.key});

  @override
  State<AjouterDepense> createState() => _AjouterDepenseState();
}

class _AjouterDepenseState extends State<AjouterDepense> {
  final int selectedIndex = 1;
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();

  @override
  void dispose() {
    _titreController.dispose();
    _descriptionController.dispose();
    _montantController.dispose();
    super.dispose();
  }

  void _validerDepense() {
    final String titre = _titreController.text.trim();
    final String description = _descriptionController.text.trim();
    final double? montant = double.tryParse(_montantController.text);

    if (titre.isEmpty || montant == null || montant <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un titre et un montant valide")),
      );
      return;
    }

    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    // Add expense via Provider
    context.read<DepenseModel>().ajouterDepense(
          titre: titre,
          description: description,
          montant: montant,
        );

    // Clear fields
    _titreController.clear();
    _descriptionController.clear();
    _montantController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Dépense ajoutée avec succès !")),
    );

    // Retour à l'écran précédent (Home)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        title: const Text("Ajouter une dépense"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // TITRE
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _titreController,
                    decoration: InputDecoration(
                      labelText: "Titre",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // MONTANT
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _montantController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Montant (€)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // DESCRIPTION
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description (Optionnelle)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // IMAGE BUTTON
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implémenter la sélection d'image
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Ajouter une image"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    side: const BorderSide(color: Colors.black54),
                  ),
                ),

                const SizedBox(height: 30),

                // AJOUTER BUTTON
                ElevatedButton.icon(
                  onPressed: _validerDepense,
                  icon: const Icon(Icons.check),
                  label: const Text("Valider la dépense"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B3FA0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BarreNavigation(
        selectedIndex: selectedIndex,
        selectedItemColor: const Color(0xFF6B3FA0),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
