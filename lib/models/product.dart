import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

   void _toggleFavorite() {
   isFavorite =
        !isFavorite; /* favorito alternando o valor sempre que chamar o metodo */
    notifyListeners(); /* para ter reatividade do botão favorito, tudo que usa produto com provider sera notificado desta forma */
   }

  Future<void> toggleFavorite() async {
    try{
    _toggleFavorite();
    final response = await http.patch(
      /* fazendo favorito ir p firebase */
      Uri.parse(('${Constants.PRODUCT_BASE_URL}/$id.json')),
      body: jsonEncode(
        {
          "isFavorite": isFavorite,
        },
      ),
    );


    if(response.statusCode >= 400) {
      _toggleFavorite(); /* restaurando favorito ao valor anterior */
    }
    } catch(_) {
      _toggleFavorite();
    }
  }
}
