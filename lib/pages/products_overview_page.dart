import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/data/dummy_data.dart';

import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha Loja',),
        
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length, /* contando o numero de elementos da lista */
        itemBuilder: (ctx, i) => ProductItem(product: loadedProducts[i]),/* exibindo a partir do contexto e indice os produtos */
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(/* area dentro de um lugar scrollable */
          crossAxisCount: 2,/* exibindo 2 produtos por linha */
          childAspectRatio: 3 / 2,/* relacão entre altura e largura */
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
