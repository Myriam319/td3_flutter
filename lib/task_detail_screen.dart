// Fichier: lib/task_detail_screen.dart (Restauration)

import 'package:flutter/material.dart';
// Correction d'importation probable pour Task
import '../models/task.dart'; 

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({required this.task, super.key});

  @override
  Widget build(BuildContext context) { // La méthode build est ajoutée/restaurée
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Tâche'),
        backgroundColor: task.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('ID: ${task.id}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Heures estimées: ${task.nbhours}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Difficulté: ${task.difficulty}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Description:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(task.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: task.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}