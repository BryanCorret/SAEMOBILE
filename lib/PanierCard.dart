import 'package:flutter/material.dart';
import 'package:sae/Produit.dart';
import 'package:sae/LocalApi.dart';
import 'package:sae/main.dart';

// La page du panier en demandant la liste localapi
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}


class _CartPageState extends State<CartPage> {
  // on récupère la liste des produits du panier
  List<Produit> cartItems = LocalApi.panier;

  void _removeItem(int index) async {
    await Future.delayed(const Duration(milliseconds: 200)); // pour simuler un chargement
    setState(() {
      LocalApi.panier.removeAt(index);
      cartItems = LocalApi.panier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalApi.getColor(), // couleur de fond noire
      appBar: AppBar(
        title: const Text('Panier'),
        actions: [
      IconButton(
        icon: const Icon(
        Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          // action du bouton panier
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          );
        },
      )],
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('Votre panier est vide',style: TextStyle(color: LocalApi.getTextColor()),),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Dismissible(
            key: Key(item.nom),
            onDismissed: (direction) {
              _removeItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.nom} a été supprimé'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            child: ListTile(
              leading: Image.network(item.image),
              title: Text(item.nom,style: TextStyle(color: LocalApi.getTextColor())),
              subtitle: Text('${item.prix} €',style: TextStyle(color: LocalApi.getTextColor())),
              trailing: Text('x1',style: TextStyle(color: LocalApi.getTextColor())),
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${calculateTotal()} €',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: LocalApi.getTextColor(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Commande passée avec succès'),
                  ),
                );
                setState(() {
                  cartItems.clear();
                });
              },
              child: const Text('Passer la commande'),
            ),
          ],
        ),
      ),
    );
  }
  // Calculer le prix total des items dans le panier
  double calculateTotal() {
    double total = 0;
    cartItems.forEach((item) {
      total += item.prix;
      // si le prix possède trop de décimales, on arrondit à 2 chiffres après la virgule
      total = double.parse(total.toStringAsFixed(2));
    });
    return total;
  }
}
