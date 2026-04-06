import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/depense_provider.dart';
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
        SnackBar(content: Text(AppLocalizations.of(context)!.errorInvalidInput)),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<DepenseProvider>().ajouterDepense(
      titre: titre,
      description: description,
      montant: montant,
    );

    _titreController.clear();
    _descriptionController.clear();
    _montantController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.successDepenseAdded)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDepenseTitle),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
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
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: "0,00",
                          hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.3)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "€",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // TITRE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.titreLabel,
                      style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titreController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.titreHint,
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: theme.colorScheme.outline),
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
                    Text(
                      AppLocalizations.of(context)!.descriptionLabel,
                      style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.descriptionHint,
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: theme.colorScheme.outline),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /*// IMAGE BUTTON
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implémenter
                  },
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: Text(AppLocalizations.of(context)!.addImage),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurface,
                    side: BorderSide(color: theme.colorScheme.onSurface),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),*/

                const SizedBox(height: 30),

                // AJOUTER BUTTON
                ElevatedButton.icon(
                  onPressed: _validerDepense,
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: Text(AppLocalizations.of(context)!.addBtn, style: const TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
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
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        showUnselectedLabels: false,
        backgroundColor: theme.colorScheme.surface,
        elevation: 10,
      ),
    );
  }
}