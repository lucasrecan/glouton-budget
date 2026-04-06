import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/depense_provider.dart';
import 'barre_navigation.dart';

class Historique extends StatelessWidget {
  const Historique({super.key});

  @override
  Widget build(BuildContext context) {
    final depenses = context.watch<DepenseProvider>().historique.reversed.toList();;
    final theme = Theme.of(context);
    int selectedIndex = 2;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.history)),

      body: depenses.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noExpenses,
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.builder(
              itemCount: depenses.length,
              itemBuilder: (context, index) {
                // On inverse l'index pour afficher la dépense la plus récente en haut
                final reversedIndex = depenses.length - 1 - index;
                final depense = depenses[reversedIndex];

                return Dismissible(
                  key: ValueKey(depense.id),
                  onDismissed: (_) {

                    // Supprimer à l'index réel de la liste chronologique
                    context.read<DepenseProvider>().supprimerDepense(reversedIndex);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.receipt),
                    title: Text(depense.titre),
                    subtitle: Text(
                      "${depense.description}\n${depense.date.day}/${depense.date.month}/${depense.date.year}",
                    ),
                    isThreeLine: depense.description.isNotEmpty,
                    trailing: Text(
                      "${depense.montant.toStringAsFixed(2)} €",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: BarreNavigation(
        selectedIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        backgroundColor: Theme.of(context).colorScheme.surface,
        showUnselectedLabels: false,
        elevation: 10,
      ),
    );
  }
}
