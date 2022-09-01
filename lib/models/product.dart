import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite =false,

  });

  void toggleFavorite() {
    isFavorite = !isFavorite; /* favorito alternando o valor sempre que chamar o metodo */
    notifyListeners(); /* para ter reatividade do botão favorito, tudo que usa produto com provider sera notificado desta forma */
  }
}