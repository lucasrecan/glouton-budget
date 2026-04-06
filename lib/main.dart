import 'package:flutter/material.dart';
import 'package:mini_projet_equipen/widgets/barre_navigation.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'models/depense_model.dart';
import 'models/preferences_provider.dart';
import 'widgets/ajoute_depense.dart';
import 'widgets/historique.dart';
import 'widgets/parametres.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DepenseModel()),
        ChangeNotifierProvider(create: (_) => PreferencesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<PreferencesProvider>().isDarkMode;
    final int selectedColor = context
        .watch<PreferencesProvider>()
        .selectedColor;
    return MaterialApp(
      title: 'Glouton Budget',
      locale: Locale(context.watch<PreferencesProvider>().selectedLanguage), // Langue dynamique
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Thème sombre
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(selectedColor),
          brightness: Brightness.dark,
        ),
      ),
      // Thème clair
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(selectedColor),
          brightness: Brightness.light,
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
  String periode = "Cette semaine";

  void ajouterRepas() {
    final bool isBoursier = context.read<PreferencesProvider>().isBoursier;
    double prix = isBoursier ? 1.0 : 3.30;

    context.read<DepenseModel>().ajouterDepense(
      titre: "Repas",
      description: isBoursier
          ? "Repas CROUS (boursier)"
          : "Repas CROUS (non boursier)",
      montant: prix,
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DepenseModel>();
    final depenses = model.historique;
    final bool isBoursier = context.watch<PreferencesProvider>().isBoursier;

    double totalCalcule = depenses.fold(0, (sum, item) => sum + item.montant);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Glouton Budget"),
        elevation: 1,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,),
              child: Text(
                "Menu",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 24),
              ),
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
                  MaterialPageRoute(
                    builder: (context) => const AjouterDepense(),
                  ),
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
              // TOTAL (utilise Provider)
              Text(
                "${totalCalcule.toStringAsFixed(2)} €",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 20),

              // DROPDOWN
              DropdownButton<String>(
                value: periode,
                underline: Container(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                items: const [
                  DropdownMenuItem(
                    value: "Cette semaine",
                    child: Text("Cette semaine"),
                  ),
                  DropdownMenuItem(value: "Ce mois", child: Text("Ce mois")),
                  DropdownMenuItem(
                    value: "Cette année",
                    child: Text("Cette année"),
                  ),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: ajouterRepas,
                    child: Text(AppLocalizations.of(context)!.addMeal),
                  ),

                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBoursier
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
                    MaterialPageRoute(
                      builder: (context) => const AjouterDepense(),
                    ),
                  );
                },
                child: const Text("Dépense personnalisée"),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BarreNavigation(
        selectedIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        backgroundColor: Theme.of(context).colorScheme.surface,
        showUnselectedLabels: false,
        elevation: 10,
      )
    );
  }
}
