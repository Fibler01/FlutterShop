import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items =
      {}; /* id do produto e item do carrinho correspondente a esse id */

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach(
      (key, cartItem) { /* para cada elemento pega o preço e multiplica pela quantidade de itens desse elemento */
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      /* se eu ja tenho um item com esse id no carrinho */
      _items.update(
        product.id,
        (existingItem) => CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            name: existingItem.name,
            quantity: existingItem.quantity + 1,
            price: existingItem.price),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            price: product.price),
      ); /* insere item se nao estiver presente */
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
