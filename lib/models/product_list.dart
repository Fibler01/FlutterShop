import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {  /* changenotifier, notifica os interessados para haver uma atualização */
  List<Product> _items = dummyProducts;  /* trocar por vazio quando pronto */
  
  List<Product> get items => [..._items];

  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount{
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null; /* se o produto tiver id */

    final product = Product(
        id:  hasId ? data['id'] as String : Random().nextDouble().toString(), /* se tem id, vai utilizar o mesmo, se nao, gera um aleatorio */
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String);

    if(hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
    
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); /* sempre que houver mudança é chamado, para atualizar a pagina, para que a tela apresente um novo produto */
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id); /* se ele encontrar id, sera um valor inteiro, caso nao, sera -1 */

    if(index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id); /* se ele encontrar id, sera um valor inteiro, caso nao, sera -1 */

    if(index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

}

// bool _showFavoriteOnly = false;

//   List<Product> get items {
//     if(_showFavoriteOnly) {
//       return _items.where((prod) => prod.isFavorite).toList(); /* where equivale a filter, retorna apenas os produtos que sao favoritos */
//     }
//     return [..._items];
//   } /* retornando um clone da lista de items, para nao permitir o usuario adicionar itens sem permissao, etc */

//   void showFavoriteOnly(){
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll(){
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }