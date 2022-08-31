
import 'package:flutter/material.dart';

import '../components/product_grid.dart';


class ProductsOverviewPage extends StatelessWidget {
  
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha Loja',),
        
      ),
      body: ProductGrid(),
    );
  }
}


