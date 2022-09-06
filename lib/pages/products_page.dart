import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';

import '../models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context); /* tendo acesso aos itens e suas quantidades */
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gerenciar produtos'),
      ),
      drawer: AppDrawer(),
      /* chamando appdrawer p conseguir voltar para loja */
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount, /* pegando quantidade de produtos */
          itemBuilder: (ctx, i) => Text(products.items[i].name),
        ),
      ),
    );
  }
}
