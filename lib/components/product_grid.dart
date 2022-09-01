import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(
        context); /* acessando os produtos a partir do provider */
    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      /* contando o numero de elementos da lista */
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem(), /* productitem recebe a partir do provider */
      ),
      /* exibindo a partir do contexto e indice os produtos */
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        /* area dentro de um lugar scrollable */
        crossAxisCount: 2,
        /* exibindo 2 produtos por linha */
        childAspectRatio: 3 / 2,
        /* relacão entre altura e largura */
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
