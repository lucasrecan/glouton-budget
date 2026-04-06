import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/preferences_provider.dart';
import 'barre_navigation.dart';

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
        title: Text(AppLocalizations.of(context)!.settingsTitle),
        elevation: 1,
        backgroundColor: Color(_selectedColor),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Mode sombre (Switch)
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.darkModeLabel),
            subtitle: Text(AppLocalizations.of(context)!.darkModeSubtitle),
            value: context.watch<PreferencesProvider>().isDarkMode,
            onChanged: (value) {
              context.read<PreferencesProvider>().setDarkMode(value);
            },
          ),
          const Divider(),

          // Statut Boursier (Radio buttons)
          ListTile(
            title: Text(AppLocalizations.of(context)!.boursierLabel),
            subtitle: Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: context.watch<PreferencesProvider>().isBoursier,
                  onChanged: (value) {
                    context.read<PreferencesProvider>().setBoursier(value!);
                  },
                ),
                Text(AppLocalizations.of(context)!.isBoursier),
                const SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: context.watch<PreferencesProvider>().isBoursier,
                  onChanged: (value) {
                    context.read<PreferencesProvider>().setBoursier(value!);
                  },
                ),
                Text(AppLocalizations.of(context)!.isNotBoursier),
              ],
            ),
          ),
          const Divider(), // barre horizontal de séparation
          // Langue (Dropdown menu)
          ListTile(
            title: Text(AppLocalizations.of(context)!.languageLabel),
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
            title: Text(AppLocalizations.of(context)!.colorLabel),
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
        ],
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
