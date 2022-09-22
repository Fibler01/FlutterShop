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

  Future<void> _refreshProducts(BuildContext context) {
    /* funcao p dar refresh na pagina chamando o metodo loadproducts */
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products =
        Provider.of(context); /* tendo acesso aos itens e suas quantidades */
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gerenciar produtos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      /* chamando appdrawer p conseguir voltar para loja */
      body: RefreshIndicator( /* adicionando função de ao arrastar p cima atualizar */
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            /* pegando quantidade de produtos */
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: products.items[i]),
                const Divider(), /* colocando divisor entre cada produto de gerenciar produtos */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
