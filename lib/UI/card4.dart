// Fichier: lib/UI/card4.dart (mis à jour avec Provider - context.watch/read)

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart'; // Importez Provider
import 'mytheme.dart';
import '../setting_viewmodel.dart'; // Importez le ViewModel

// Converti en StatelessWidget : l'état est maintenant géré par le ViewModel
class EcranSettings extends StatelessWidget {
  const EcranSettings({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 context.watch() : Écoute les changements dans le ViewModel pour mettre à jour l'UI (le switch)
    final isDark = context.watch<SettingViewModel>().isDark; 

    return Center(
      child: SettingsList(
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
                // Utilise l'état lu du ViewModel
                initialValue: isDark, 
                // 💡 context.read() : Accède au ViewModel pour appeler une méthode (modifier l'état)
                // sans déclencher une reconstruction de ce widget.
                onToggle: (bool value) {
                  context.read<SettingViewModel>().isDark = value;
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