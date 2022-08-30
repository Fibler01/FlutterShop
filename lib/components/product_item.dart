import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      /* para arredondar bordas dos widgets dentro dele */
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(  /* para detectar o click ontap */
          child: Image.network(
            product.imageUrl,
            /* mostrando a imagem do produto */
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.PRODUCT_DETAIL,
            arguments: product,); /* ao clicar, navega para productdetailpage */
           
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            /* para permitir favoritar o produto */
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
