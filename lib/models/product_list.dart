import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {  /* changenotifier, notifica os interessados para haver uma atualização */
  List<Product> _items = dummyProducts;  /* trocar por vazio quando pronto */

  List<Product> get items => [..._items]; /* retornando um clone da lista de items, para nao permitir o usuario adicionar itens sem permissao, etc */

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); /* sempre que houver mudança é chamado, para atualizar a pagina, para que a tela apresente um novo produto */
  }

}