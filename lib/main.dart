import 'package:flutter/material.dart';
import 'widgets/ajoute_depense.dart';
import 'widgets/historique.dart';
import 'widgets/parametres.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glouton Budget',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B3FA0),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // la navigation de navigation bar
  double total = 0.0;
  String periode = "Cette semaine";
  bool estBoursier = false;

  void ajouterRepas() {
    setState(() {
      total += estBoursier ? 1.0 : 3.30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),

      appBar: AppBar(
        title: const Text("Glouton Budget"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Menu"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text("Ajouter dépense"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjouterDepense()),
                );
              },
            ),

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

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Paramètres"),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Parametres()),
                );

                if (result != null) {
                  setState(() {
                    estBoursier = result;
                  });
                }
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

              // TOTAL
              Text(
                "${total.toStringAsFixed(2)} €",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D2D2D)),
              ),

              const SizedBox(height: 20),

              // DROPDOWN
              DropdownButton<String>(
                value: periode,
                underline: Container(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                items: const [
                  DropdownMenuItem(value: "Cette semaine", child: Text("Cette semaine")),
                  DropdownMenuItem(value: "Ce mois", child: Text("Ce mois")),
                  DropdownMenuItem(value: "Cette année", child: Text("Cette année")),
                  DropdownMenuItem(value: "Tout", child: Text("Tout")),
                ],
                onChanged: (value) {
                  setState(() {
                    periode = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // AJOUT REPAS + INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B3FA0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: ajouterRepas,
                    child: const Text("Ajouter un repas"),
                  ),

                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            estBoursier
                                ? "Repas CROUS : 1€ (boursier)"
                                : "Repas CROUS : 3.30€ (non boursier)",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // AUTRE DEPENSE
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AjouterDepense()),
                  );
                },
                child: const Text("Dépense personnalisée"),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF6B3FA0),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,

          onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AjouterDepense()),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Historique(),
              ),
            );
          }

          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Parametres()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Ajouter",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historique",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }
}
