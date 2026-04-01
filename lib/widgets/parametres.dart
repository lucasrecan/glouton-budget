import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isBoursier = prefs.getBool('isBoursier') ?? false;
      _isDarkMode = prefs.getBool('isDarkMode') ?? true;
      _selectedColor = prefs.getInt('selectedColor') ?? Colors.purple.toARGB32();
      _selectedLanguage = prefs.getString('selectedLanguage') ?? 'fr';
    });
  }

  Future<void> _savePreferences() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isBoursier', _isBoursier);
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setInt('selectedColor', _selectedColor);
    await prefs.setString('selectedLanguage', _selectedLanguage);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Préférences enregistrées !')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: Color(_selectedColor),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          // 1. Mode sombre (Switch)
          SwitchListTile(
            title: const Text("Mode Sombre"),
            subtitle: const Text("Activer le thème sombre"),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });;
            },
          ),
          const Divider(),

          // 2. Statut Boursier (Radio Buttons)
          ListTile(
            title: const Text("Statut étudiant"),
            subtitle: Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _isBoursier,
                  onChanged: (value) {
                    setState(() {
                      _isBoursier = value!;
                    });;
                  },
                ),
                const Text("Boursier"),
                const SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: _isBoursier,
                  onChanged: (value) {
                    setState(() {
                      _isBoursier = value!;
                    });
                  },
                ),
                const Text("Non boursier"),
              ],
            ),
          ),
          const Divider(), // barre horizontal de séparation

          // 3. Langue (Dropdown Menu)
          ListTile(
            title: const Text("Langue de l'application"),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'fr', child: Text("Français")),
                DropdownMenuItem(value: 'en', child: Text("English")),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                }
              },
            ),
          ),
          const Divider(),

          // 4. Couleur principale (Cercles sélectionnables)
          ListTile(
            title: const Text("Couleur principale"),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 12,
                children: _availableColors.map((color) {
                  final isSelected = _selectedColor == color.toARGB32();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color.toARGB32();
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black87 : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _savePreferences,
            icon: const Icon(Icons.save),
            label: const Text("Enregistrer les modifications"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50), // Bouton large
            ),
          ),
        ],
      ),
    );
  }
}