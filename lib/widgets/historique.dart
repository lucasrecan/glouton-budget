import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/depense_model.dart';

class Historique extends StatelessWidget {
  const Historique({super.key});

  @override
  Widget build(BuildContext context) {
    final depenses = context.watch<DepenseModel>().historique;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
      ),

      body: depenses.isEmpty
          ? const Center(
        child: Text("Aucune dépense pour le moment"),
      )
          : ListView.builder(
        itemCount: depenses.length,
        itemBuilder: (context, index) {
          final depense = depenses[index];

          return ListTile(
            leading: const Icon(Icons.receipt),
            title: Text(depense.titre),
            subtitle: Text(depense.description),
            trailing: Text(
              "${depense.montant.toStringAsFixed(2)} €",
            ),
          );
        },
      ),
    );
  }
}