// Fichier: lib/UI/card1.dart (mis à jour avec TaskViewModel)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ NOUVEL IMPORT
import '../models/task.dart';
import 'detail.dart';
import '../task_viewmodel.dart'; // Importez le TaskViewModel

// Ecran1 devient un widget qui utilise les données du ViewModel
class Ecran1 extends StatelessWidget {
  // Suppression de la déclaration statique des tâches
  // final List<Task> myTasks = Task.generateTask(6); // Suppression
  
  const Ecran1({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 context.watch<TaskViewModel>().liste :
    // Récupère la liste de tâches et force la reconstruction si notifyListeners() est appelé dans TaskViewModel
    final List<Task> tasks = context.watch<TaskViewModel>().liste;

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final Task task = tasks[index]; // Utilisez 'task' pour la clarté
        
        return Card(
          color: task.color.withOpacity(0.1), // Utilisation de task.color
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: task.color,
              child: Text(task.id.toString()),
            ),
            title: Text(task.title),
            subtitle: Text(task.tags.join(" ")),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) 
                    => Detail(task: task),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
