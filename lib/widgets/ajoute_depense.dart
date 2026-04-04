import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/depense_model.dart';
import 'barre_navigation.dart';
import 'historique.dart';

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
    
    final String montantText = _montantController.text.replaceAll(',', '.');
    final double? montant = double.tryParse(montantText);

    if (titre.isEmpty || montant == null || montant <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un titre et un montant valide")),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<DepenseModel>().ajouterDepense(
          titre: titre,
          description: description,
          montant: montant,
        );

    _titreController.clear();
    _descriptionController.clear();
    _montantController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Dépense ajoutée avec succès !")),
    );

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
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Historique()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: TextField(
                        controller: _montantController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: "0,00",
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "€",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // TITRE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Titre",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titreController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Titre",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // DESCRIPTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description :",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Mettre un description ici...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // IMAGE BUTTON
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implémenter
                  },
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text("Ajouter une image"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black87),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // AJOUTER BUTTON
                ElevatedButton.icon(
                  onPressed: _validerDepense,
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text("Ajouter", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B3FA0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
        backgroundColor: const Color(0xFFF5F0FF),
        elevation: 0,
      ),
    );
  }
}
