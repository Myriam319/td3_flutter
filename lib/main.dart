// Fichier: lib/main.dart (mis à jour avec MultiProvider)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/mytheme.dart';
import 'UI/home.dart';
import 'setting_viewmodel.dart';
import 'task_viewmodel.dart'; // ✅ NOUVEL IMPORT

void main() {
  runApp(const MyTD2());
}

class MyTD2 extends StatelessWidget {
  const MyTD2({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Utilisation de MultiProvider pour fournir plusieurs ViewModels
    return MultiProvider(
      providers: [
        // Provider 1: Pour la gestion du thème
        ChangeNotifierProvider(
          create: (_) {
            SettingViewModel settingViewModel = SettingViewModel();
            // getSettings() est déjà appelée dans le constructeur
            return settingViewModel;
          },
        ),
        // Provider 2: Pour la gestion des tâches
        ChangeNotifierProvider(
          create: (_) {
            TaskViewModel taskViewModel = TaskViewModel();
            taskViewModel.generateTasks(); // Charge les 50 tâches au démarrage
            return taskViewModel;
          },
        ),
      ],
      // 2. Consumer écoute uniquement le SettingViewModel pour mettre à jour le thème
      child: Consumer<SettingViewModel>(
        builder: (context, notifier, child) {
          return MaterialApp(
            theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
            title: 'TD2',
            home: Home(),
          );
        },
      ),
    );
  }
}