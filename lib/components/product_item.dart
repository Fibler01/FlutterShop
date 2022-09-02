import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    ); /* pegando produto a partir do contexto do provider, ou seja, loadedproducts[i] do product grid  */
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return ClipRRect(
      /* para arredondar bordas dos widgets dentro dele */
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          /* para detectar o click ontap */
          child: Image.network(
            product.imageUrl,
            /* mostrando a imagem do produto */
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            ); /* ao clicar, navega para productdetailpage */
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              /* para permitir favoritar o produto, caso produto é favorito mostra o icone preenchido, se não, mostra apenas a borda */
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
             
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
