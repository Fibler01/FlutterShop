import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  
  const ProductDetailPage({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product; /* pegando os argumentos passados pela rota, ! pois dentro do settings sempre estara garantido que tera um produto */
    return Scaffold(
      appBar: AppBar(
        title:  Text(product.title),
      ),
    );
  }
}
