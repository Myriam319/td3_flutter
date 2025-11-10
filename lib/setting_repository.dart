// Fichier: lib/setting_repository.dart (Restauration)

// Importation nécessaire pour utiliser SharedPreferences
import 'package:shared_preferences/shared_preferences.dart'; 

class SettingRepository {
  static const THEME_KEY = "darkMode";

  // Sauvegarde la valeur booléenne du thème
  saveSettings(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  // Récupère la valeur sauvegardée. Retourne 'false' (thème clair) par défaut si aucune valeur n'existe.
  Future<bool> getSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Le '?? false' est important pour définir une valeur par défaut
    return sharedPreferences.getBool(THEME_KEY) ?? false; 
  }
}
