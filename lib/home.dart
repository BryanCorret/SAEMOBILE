import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sae/Produit.dart';
import 'package:sae/LocalApi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produit> _products = [];

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  Future<void> _getProducts() async {
    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _products = data
            .map((product) => Produit(
          nom: product['title'],
          description: product['description'],
          image: product['image'],
          prix: product['price'].toDouble(),
        ))
            .toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LocalApi.getColor(),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            final product = _products[index];
            return Column(
              children: [
                Expanded(
                  child: Image.network(product.image),
                ),
                Text(
                  product.nom,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LocalApi.getTextColor(),

                  ),
                ),
                Text('${product.prix} €', style: TextStyle(
                  color: LocalApi.getTextColor(),
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Ajouter le produit au panier
                        LocalApi.add("panier", product);
                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text('${product.nom} a été ajouté au panier',style: TextStyle(
                              color: LocalApi.getTextColor(),
                            ),),
                          ),
                        );
                        debugPrint(LocalApi.getPanier().toString());
                      },
                      child: const Icon(Icons.add_shopping_cart ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Ajouter le produit aux favoris
                        LocalApi.add("favoris", product);
                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text('${product.nom} a été ajouté aux favoris'
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: const Icon(Icons.favorite),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
