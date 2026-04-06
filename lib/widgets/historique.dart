import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/depense_provider.dart';
import 'barre_navigation.dart';

class Historique extends StatelessWidget {
  const Historique({super.key});

  @override
  Widget build(BuildContext context) {
    final depenses = context.watch<DepenseProvider>().historique;
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
                final depense = depenses[index];

                return Dismissible(
                  key: ValueKey(depense),
                  onDismissed: (_) {
                    context.read<DepenseProvider>().supprimerDepense(index);
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: const Icon(Icons.receipt),
                    title: Text(depense.titre),
                    subtitle: Text(
                      "${depense.description}\n${depense.date.day}/${depense.date.month}/${depense.date.year}",
                    ),
                    isThreeLine: depense.description.isNotEmpty,
                    trailing: Text("${depense.montant.toStringAsFixed(2)} €"),
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
