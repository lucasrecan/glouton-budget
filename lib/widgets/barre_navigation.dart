import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'parametres.dart';
import 'ajoute_depense.dart';
import 'historique.dart';

class BarreNavigation extends StatefulWidget {
  final int selectedIndex;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final bool showUnselectedLabels;
  final Color backgroundColor;
  final double elevation;

  const BarreNavigation({
    super.key,
    required this.selectedIndex,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.showUnselectedLabels,
    required this.backgroundColor,
    required this.elevation,
  });

  @override
  State<BarreNavigation> createState() => _BarreNavigationState();
}

class _BarreNavigationState extends State<BarreNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      showUnselectedLabels: widget.showUnselectedLabels,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      type: BottomNavigationBarType.fixed, // bien pour plus de 3 items

      onTap: (index) {
        if (index == widget.selectedIndex) return;

        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AjouterDepense()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Historique()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Parametres()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.navigationMenu),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: AppLocalizations.of(context)!.navigationAdd,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: AppLocalizations.of(context)!.navigationHistory,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.navigationSettings,
        ),
      ],
    );
  }
}