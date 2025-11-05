// Fichier: card3.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// CORRECTION 1: Utilisez le chemin d'accès correct pour Task
// Si task.dart est dans lib/models
import '../models/task.dart'; // Importez votre classe Task
// CORRECTION 2: Utilisez l'écran de détail existant 'detail.dart' (qui contient la classe Detail)
import 'detail.dart'; // Importez le nouvel écran de détail (assumons que c'est Detail)


// Modèle pour les données de l'API (pour correspondre à Task)
class PostTask {
  final int id;
  final String title;
  final String description; // Utiliser 'body' de l'API comme description

  PostTask({
    required this.id,
    required this.title,
    required this.description,
  });

  factory PostTask.fromJson(Map<String, dynamic> json) {
    return PostTask(
      id: json['id'],
      title: json['title'],
      description: json['body'] ?? 'No description provided', // Utilise 'body'
    );
  }

  // Conversion en votre classe Task pour la cohérence
  Task toTask() {
    return Task(
      id: id,
      title: title,
      tags: ['API'], // Tag par défaut
      nbhours: 1, // Valeur par défaut
      difficulty: 1, // Valeur par défaut
      description: description,
      color: Colors.lightGreen,
    );
  }
}


class Ecran3 extends StatefulWidget {
  const Ecran3({super.key});

  @override
  State<Ecran3> createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  // Future pour stocker le résultat de la requête HTTP
  late Future<List<PostTask>> futurePostTasks;

  @override
  void initState() {
    super.initState();
    futurePostTasks = fetchPostTasks();
  }

  // Fonction pour effectuer la requête HTTP et désérialiser le JSON
  Future<List<PostTask>> fetchPostTasks() async {
    // Utilisation de l'API /posts pour avoir plus de champs pour la description
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // Si le serveur retourne un code 200 OK, analyse le JSON
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => PostTask.fromJson(item)).toList();
    } else {
      // Si la réponse n'est pas OK, lance une exception
      throw Exception('Failed to load tasks from API');
    }
  }

  // Fonction de navigation
  void _navigateToDetail(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // CORRECTION 3: Utiliser la classe 'Detail' à la place de 'TaskDetailScreen'
        builder: (context) => Detail(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecran 3 - API Tasks'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: FutureBuilder<List<PostTask>>(
        future: futurePostTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant l'attente
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Afficher une erreur si la requête échoue
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Afficher la ListView si les données sont prêtes
            return Container(
              color: Colors.lightGreenAccent.withOpacity(0.5),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final postTask = snapshot.data![index];
                  final task = postTask.toTask(); // Conversion en Task

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: task.color,
                        child: Text('${task.id}'),
                      ),
                      title: Text(task.title),
                      subtitle: Text('User ID: ${task.id}, ${task.tags.first}', overflow: TextOverflow.ellipsis),
                      onTap: () {
                        // Navigation vers l'écran de détail au clic
                        _navigateToDetail(task);
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            // Cas par défaut (pas de données)
            return const Center(child: Text('Aucune tâche trouvée'));
          }
        },
      ),
    );
  }
}