// Fichier: lib/UI/card4.dart (mis à jour avec Provider)

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart'; // NOUVEL IMPORT
import 'mytheme.dart';
import '../setting_viewmodel.dart'; // Import du ViewModel

// ✅ Converti en StatelessWidget car l'état est dans le ViewModel
class EcranSettings extends StatelessWidget { 
  const EcranSettings({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilise context.read pour obtenir l'instance sans écouter
    final settingViewModel = context.read<SettingViewModel>();
    
    // Utilise context.watch pour lire l'état (ou on lit directement le getter)
    final bool isDark = settingViewModel.isDark;

    return Center(
      child: SettingsList(
        // ... (Le reste des thèmes SettingsList)
        darkTheme: SettingsThemeData(
          settingsListBackground: MyTheme.dark().scaffoldBackgroundColor,
          settingsSectionBackground: MyTheme.dark().scaffoldBackgroundColor,
        ),
        lightTheme: SettingsThemeData(
          settingsListBackground: MyTheme.light().scaffoldBackgroundColor,
          settingsSectionBackground: MyTheme.light().scaffoldBackgroundColor,
        ),
        sections: [
          SettingsSection(
            title: const Text('Theme'),
            tiles: [
              SettingsTile.switchTile(
                // ✅ InitialValue lit l'état du ViewModel
                initialValue: isDark, 
                onToggle: (value) {
                  // ✅ L'action appelle le setter du ViewModel
                  settingViewModel.isDark = value;
                },
                title: const Text('Dark mode'),
                leading: const Icon(Icons.invert_colors),
              ),
            ],
          ),
        ],
      ),
    );
  }
}