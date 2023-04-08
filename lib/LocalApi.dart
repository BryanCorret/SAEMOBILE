import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sae/Produit.dart';

class LocalApi {
  static List<Produit> panier = [];
  static List<Produit> favorite = [];
  static bool darkTheme = false;

  static getColor() {
   if (darkTheme == true) {
     return Colors.grey[900];
   } else {
     return Colors.grey[200];
   }
  }

  static getTextColor() {
    if (darkTheme == true) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static void setDarkTheme(bool value) async {
    darkTheme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', 'refresh');
  }

  static bool getDarkTheme() {
    return darkTheme;
  }

  static Future<bool> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('theme');
    if (data != null) {
      if (data == 'refresh') {
        prefs.setString('theme', 'no_refresh');
        return true;
      }
    }
    return false;
  }

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('panier');
    final data2 = prefs.getString('favorite');
    if (data != null) {
        final List<dynamic> list = jsonDecode(data);
        panier = list.map((item) =>
            Produit(
                nom: item['nom'],
                description: item['description'],
                image: item['image'],
                prix: item['prix'].toDouble(),
            )).toList();
    }
    if (data2 != null) {
      final List<dynamic> list = jsonDecode(data2);
      favorite = list.map((item) => Produit(
        nom: item['nom'],
        description: item['description'],
        image: item['image'],
        prix: item['prix'].toDouble(),
      )).toList();
    }
  }

  static Future<void> add(String Panier_ou_favorite ,Produit produit) async {
      if (Panier_ou_favorite == 'panier') {
      panier.add(produit);
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(panier.map((item) => {
        'nom': item.nom,
        'description': item.description,
        'image': item.image,
        'prix': item.prix,
      }).toList());
      await prefs.setString('panier', data);
    } else {
      favorite.add(produit);
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(favorite.map((item) => {
        'nom': item.nom,
        'description': item.description,
        'image': item.image,
        'prix': item.prix,
      }).toList());
      await prefs.setString('favorite', data);
    }
  }
  static Future<void> remove(String Panier_ou_favorite ,Produit produit) async {
    if (Panier_ou_favorite == 'panier') {
      panier.remove(produit);
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(panier.map((item) => {
        'nom': item.nom,
        'description': item.description,
        'image': item.image,
        'prix': item.prix,
      }).toList());
      await prefs.setString('panier', data);
    } else {
      favorite.remove(produit);
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(favorite.map((item) => {
        'nom': item.nom,
        'description': item.description,
        'image': item.image,
        'prix': item.prix,
      }).toList());
      await prefs.setString('favorite', data);
    }
  }

  static Future<void> clear(String Panier_ou_favorite) async {
    if (Panier_ou_favorite == 'panier') {
      panier.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('panier', "");
    } else {
      favorite.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('favorite', "");
    }
  }

  static int count(String Panier_ou_favorite) {
    if (Panier_ou_favorite == 'panier') {
      return panier.length;
    } else {
      return favorite.length;
    }
  }
  static List<Produit> getPanier() {
    return panier;
  }
  static List<Produit> getFavorite() {
    return favorite;
  }
}
