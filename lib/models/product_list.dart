import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';

import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  /* changenotifier, notifica os interessados para haver uma atualização */
   /* base do firebase */
  List<Product> _items = []; /* trocar por vazio quando pronto */

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items
        .clear(); /* para evitar ficar acumulando produtos duplicados sempre */
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'),
    );
    if (response.body == 'null') return;
    /* print(jsonDecode(response.body)); */
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Product(
          /* adicionando um produto a partir da resposta do que tem no _url */
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    }); /* percorrendo cada um dos elementos */

    notifyListeners(); /* alterando conteudo da lista de items, por isso deve-se chamar notifylisteners */
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null; /* se o produto tiver id */

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        /* se tem id, vai utilizar o mesmo, se nao, gera um aleatorio */
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String);

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    /* async significa que podemos programar o codigo como sincrono */
    final response = await http.post(
      /* aguardando a resposta */
      /* o tempo que demora da requisicao e resposta é tratado como future, post equivale a add */
      Uri.parse(('${Constants.PRODUCT_BASE_URL}.json')),
      /* definindo local/coleção que quero armazenar os dados, tem que terminar com .json p funcionar*/
      body: jsonEncode(
        {
          /* transformando o objeto que irei passar (produto) em um json, chave valor */
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    /* print(jsonDecode(response.body)); */ /* vendo o que veio no corpo da resposta para pegar o ID que foi gerado no firebase */
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
    /* sempre que houver mudança é chamado, para atualizar a pagina, para que a tela apresente um novo produto */
    /* apos a requisicao e resposta, é adicionado o produto dentro de _items */
  }

  Future<void> updateProduct(Product product) async {
    /* future pois não se sabe quanto tempo demorará a conexão */
    int index = _items.indexWhere((p) =>
        p.id ==
        product
            .id); /* se ele encontrar id, sera um valor inteiro, caso nao, sera -1 */

    if (index >= 0) {
      await http.patch(
        /* o mesmo que o add, so muda que é patch e a definicao do productid*/
        Uri.parse(('${Constants.PRODUCT_BASE_URL}/${product.id}.json')),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) =>
        p.id ==
        product
            .id); /* se ele encontrar id, sera um valor inteiro, caso nao, sera -1 */

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        /* o mesmo que o add, so muda que é patch */
        Uri.parse(('${Constants.PRODUCT_BASE_URL}/${product.id}.json')),
      );

      if (response.statusCode >= 400) {
        /* erro da familia do 400/500, cliente ou servidor respectivamente */
        _items.insert(index,
            product); /* reinsere o item caso tenha apagado local mas não apagou no servidor */
        notifyListeners();
        throw HttpException(
            msg: 'Não foi possível excluir o produto.',
            statusCode: response.statusCode);
      }
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