import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products =
        Provider.of(context); /* tendo acesso aos itens e suas quantidades */
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gerenciar produtos'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
          }, icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      /* chamando appdrawer p conseguir voltar para loja */
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          /* pegando quantidade de produtos */
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(product: products.items[i]),
              Divider(), /* colocando divisor entre cada produto de gerenciar produtos */
            ],
          ),
        ),
      ),
    );
  }
}
