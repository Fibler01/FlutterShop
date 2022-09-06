import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'pages/cart_page.dart';
import 'pages/orders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /* envolvendo main com provider, para ter ele a disposição dentro de toda a arvore de componentes */
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(), /* criando instancia de changenotifier */
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        /* home: ProductsOverviewPage(), */
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
