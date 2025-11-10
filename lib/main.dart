// Fichier: lib/main.dart (Intégration de Provider et Consumer)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez Provider
import 'UI/mytheme.dart';
import 'UI/home.dart'; 
import 'setting_viewmodel.dart'; // Importez le ViewModel

void main() {
  // WidgetsFlutterBinding.ensureInitialized() n'est plus nécessaire ici
  // car le chargement asynchrone est géré dans le constructeur/méthode du ViewModel.
  runApp(const MyTD2());
}

// Renommez ou modifiez votre ancienne classe MyTD2App
class MyTD2 extends StatelessWidget {
  const MyTD2({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ChangeNotifierProvider injecte le ViewModel à la racine
    return ChangeNotifierProvider<SettingViewModel>(
      // La fonction create est appelée une seule fois
      create: (_) {
        SettingViewModel settingViewModel = SettingViewModel();
        // getSettings() est déjà appelé dans le constructeur du ViewModel,
        // ce qui garantit que l'état initial est chargé.
        return settingViewModel;
      },
      
      // 2. Consumer écoute le ViewModel et ne reconstruit que son builder
      child: Consumer<SettingViewModel>(
        // Le builder reçoit l'instance du ViewModel (notifier)
        builder: (context, notifier, child) {
          // Utilise l'état isDark du ViewModel pour choisir le thème
          final theme = notifier.isDark ? MyTheme.dark() : MyTheme.light();

          return MaterialApp(
            theme: theme,
            title: 'TD2',
            home: Home(), // Utilise la page d'accueil principale
          );
        },
      ),
    );
  }
}