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

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); /* sempre que houver mudança é chamado, para atualizar a pagina, para que a tela apresente um novo produto */
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