import 'package:flutter/material.dart';
import 'ajoute_depense.dart';
import 'historique.dart';
import 'parametres.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glouton Budget"),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Menu
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Menu"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Ajouter dépense
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter dépense"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterDepense()),
                );
              },
            ),

            // Historique
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Historique"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Historique()),
                );
              },
            ),

            // Paramètres
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Paramètres"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Parametres()),
                );
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "0,00 €",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              DropdownButton<String>(
                value: "Cette semaine",
                underline: Container(),
                items: const [
                  DropdownMenuItem(value: "Cette semaine", child: Text("Cette semaine")),
                  DropdownMenuItem(value: "Ce mois", child: Text("Ce mois")),
                  DropdownMenuItem(value: "Cette année", child: Text("Cette année")),
                  DropdownMenuItem(value: "Tout", child: Text("Tout")),
                ],
                onChanged: (value) {},
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text("Ajouter un repas"),
              ),

              const SizedBox(height: 20),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text("Dépense personnalisée"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
