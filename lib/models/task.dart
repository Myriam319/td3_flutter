// Fichier: lib/models/task.dart (Modification du modèle Task)

import 'package:flutter/material.dart';
// Autres imports si nécessaires...

class Task {
  final int id;
  final String title;
  final List<String> tags;
  final int nbhours;
  final int difficulty;
  final String description;
  final Color color;

  // 💡 NOUVEAU : Attribut statique pour l'auto-incrémentation de l'ID
  static int nb = 0; 

  Task({
    required this.id,
    required this.title,
    required this.tags,
    required this.nbhours,
    required this.difficulty,
    required this.description,
    required this.color,
  });

  // 💡 NOUVEAU : Factory pour créer une nouvelle tâche auto-incrémentée
  factory Task.newTask() {
    // Incrémente le compteur statique pour obtenir un nouvel ID
    nb++; 
    return Task(
      id: nb, 
      title: 'title $nb', 
      tags: ['tags $nb'], 
      nbhours: nb, 
      difficulty: nb % 5, // Difficulté cyclique de 0 à 4 (ou 1 à 5 si nb % 5 + 1)
      description: 'description $nb',
      color: Colors.blueGrey, // Couleur par défaut
    );
  }

  // Assurez-vous que vos autres factories (fromJson, generateTask, etc.) sont toujours présentes.

  // Exemple de factory fromJson si vous l'utilisez
  factory Task.fromJson(Map<String, dynamic> json) {
    // ... implémentation existante pour charger depuis JSON ...
    // NOTE: Si vous générez des tâches via newTask(), assurez-vous de gérer 
    // l'initialisation de 'nb' si vous chargez des données existantes.
    return Task(
      id: json['id'],
      title: json['title'],
      tags: List<String>.from(json['tags'] ?? []),
      nbhours: json['nbhours'] ?? 1,
      difficulty: json['difficulty'] ?? 1,
      description: json['description'] ?? '',
      color: Colors.blueGrey, // À adapter selon la couleur dans le JSON
    );
  }
  
  // Exemple de méthode statique pour générer une liste de tâches
  static List<Task> generateTask(int count) {
      return List.generate(count, (index) {
          nb = index + 1; // Optionnel : réinitialiser nb pour la génération simple
          return Task(
              id: nb,
              title: 'Tâche locale $nb',
              tags: ['Tag A', 'Tag ${nb % 3}'],
              nbhours: (nb * 2) % 10 + 1,
              difficulty: nb % 5 + 1,
              description: 'Ceci est la description de la tâche locale numéro $nb.',
              color: [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple][nb % 5],
          );
      });
  }
}
