import 'package:flutter/material.dart';
import 'package:sae/FavoriteCard.dart';
import 'package:sae/home.dart';
import 'package:sae/PanierCard.dart';
import 'package:sae/LocalApi.dart';
import 'package:sae/Setting.dart';
import 'package:sae/loginCard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   // localApi Panier
  await LocalApi.init();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Mon Application',
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // action du bouton panier
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CartPageFav(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // action du bouton paramètres
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(

                            builder: (context) => SettingPage(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // action du bouton utilisateur
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}

