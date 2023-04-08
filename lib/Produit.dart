
import 'package:flutter/material.dart';

class Produit extends StatelessWidget {
  final String nom;
  final String description;
  final String image;
  final double prix;

  const Produit({
    Key? key,
    required this.nom,
    required this.description,
    required this.image,
    required this.prix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Image.network(
              image,
              fit: BoxFit.cover,  // pour que l'image prenne toute la place disponible
            ), // Image.network pour afficher une image à partir d'une URL
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nom,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '\$$prix',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // fonction fromJson pour convertir un objet JSON en un objet Produit
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      nom: json['title'],
      description: json['description'],
      image: json['image'],
      prix: json['price'].toDouble(),
    );

  }
  // fonction toJson pour convertir un objet Produit en un objet JSON
  Map<String, dynamic> toJson() => {
    'title': nom,
    'description': description,
    'image': image,
    'price': prix,
  };

}