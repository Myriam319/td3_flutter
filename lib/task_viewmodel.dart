// Fichier: lib/task_viewmodel.dart

import 'package:flutter/material.dart';
import 'models/task.dart'; // Importez votre classe Task

class TaskViewModel extends ChangeNotifier {
  // Utilisez la bonne classe/type pour la liste (List<Task> est préférable à List)
  late List<Task> liste; 

  TaskViewModel() {
    liste = [];
  }

  void addTask(Task task) {
    liste.add(task);
    notifyListeners();
  }

  void generateTasks() {
    // 💡 Appelle la méthode statique que vous avez ajoutée à la classe Task
    liste = Task.generateTask(50); 
    notifyListeners();
  }
  
  // Vous pourriez ajouter d'autres méthodes ici (deleteTask, updateTask, etc.)
}