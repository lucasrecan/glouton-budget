import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/preferences_provider.dart';
import 'barre_navigation.dart';

/*
Paramètres intéressants :
- boursier/pas boursier
- mode sombre/clair
- couleur global de l'application ?
- langue de l'application (ne pas nécessiter un reload de l'app ?)

 */

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  bool _isBoursier = false;
  bool _isDarkMode = true;
  int _selectedColor = Colors.purple.toARGB32();
  String _selectedLanguage = 'fr';
  int selectedIndex = 3;

  // Liste de couleurs proposées pour l'application
  final List<Color> _availableColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isBoursier = context.watch<PreferencesProvider>().isBoursier;
    _isDarkMode = context.watch<PreferencesProvider>().isDarkMode;
    _selectedColor = context.watch<PreferencesProvider>().selectedColor;
    _selectedLanguage = context.watch<PreferencesProvider>().selectedLanguage;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: Color(_selectedColor),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Mode sombre (Switch)
          SwitchListTile(
            title: const Text("Mode Sombre"),
            subtitle: const Text("Activer le thème sombre"),
            value: context.watch<PreferencesProvider>().isDarkMode,
            onChanged: (value) {
              context.read<PreferencesProvider>().setDarkMode(value);
            },
          ),
          const Divider(),

          // Statut Boursier (Radio Buttons)
          ListTile(
            title: const Text("Statut étudiant"),
            subtitle: Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: context.watch<PreferencesProvider>().isBoursier,
                  onChanged: (value) {
                    context.read<PreferencesProvider>().setBoursier(value!);
                  },
                ),
                const Text("Boursier"),
                const SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: context.watch<PreferencesProvider>().isBoursier,
                  onChanged: (value) {
                    context.read<PreferencesProvider>().setBoursier(value!);
                  },
                ),
                const Text("Non boursier"),
              ],
            ),
          ),
          const Divider(), // barre horizontal de séparation
          // Langue (Dropdown Menu)
          ListTile(
            title: const Text("Langue de l'application"),
            trailing: DropdownButton<String>(
              value: context.watch<PreferencesProvider>().selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'fr', child: Text("Français")),
                DropdownMenuItem(value: 'en', child: Text("English")),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.read<PreferencesProvider>().setSelectedLanguage(
                    newValue,
                  );
                }
              },
            ),
          ),
          const Divider(),

          // Couleur principale (Cercles sélectionnables)
          ListTile(
            title: const Text("Couleur principale"),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 12,
                children: _availableColors.map((color) {
                  final isSelected =
                      context.watch<PreferencesProvider>().selectedColor ==
                      color.toARGB32();
                  return GestureDetector(
                    onTap: () {
                      context.read<PreferencesProvider>().setSelectedColor(
                        color.toARGB32(),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Colors.black87
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // const SizedBox(height: 30),
          // ElevatedButton.icon(
          //   onPressed: _savePreferences,
          //   icon: const Icon(Icons.save),
          //   label: const Text("Enregistrer les modifications"),
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: const Size.fromHeight(50), // Bouton large
          //   ),
          // ),
        ],
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
