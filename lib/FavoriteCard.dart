import 'package:flutter/material.dart';
import 'package:sae/Produit.dart';
import 'package:sae/LocalApi.dart';
import 'package:sae/main.dart';

// La page du panier en demandant la liste localapi
class CartPageFav extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}


class _CartPageState extends State<CartPageFav> {
  // on récupère la liste des produits du panier
  List<Produit> cartItems = LocalApi.favorite;

  void _removeItem(int index) async {
    await Future.delayed(const Duration(milliseconds: 200)); // pour simuler un chargement
    setState(() {
      LocalApi.favorite.removeAt(index);
      cartItems = LocalApi.favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
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
      body: Container(
        color: LocalApi.getColor(), // couleur de fond noire
        child: cartItems.isEmpty
            ? Center(
          child: Text('Votre liste de favoris est vide',style: TextStyle(color: LocalApi.getTextColor()),),
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
      ),
    );
  }
}

