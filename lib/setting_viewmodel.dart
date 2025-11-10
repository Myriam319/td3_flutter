// Fichier: lib/setting_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'setting_repository.dart'; // Importez votre repository

class SettingViewModel extends ChangeNotifier {
  late bool _isDark;
  late SettingRepository _settingRepository;

  // Getter : utilisé par le Material App pour lire l'état actuel du thème
  bool get isDark => _isDark;

  SettingViewModel() {
    _isDark = false;
    _settingRepository = SettingRepository();
    getSettings();
  }

  // Setter : utilisé par le bouton du thème pour modifier l'état
  set isDark(bool value) {
    _isDark = value;
    _settingRepository.saveSettings(value);
    // 💡 Déclenche la reconstruction de tous les widgets qui 'écoutent' ce ViewModel
    notifyListeners();
  }

  // Charge l'état sauvegardé au démarrage de l'application
  void getSettings() async {
    _isDark = await _settingRepository.getSettings();
    notifyListeners();
  }
}