import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true; /* é stateful pcausa do loading, que muda a tela */

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((_) {
      setState(() => _isLoading =
          false); /* para o loading ao carregar a lista de pedidos */
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: const Center(
                child: CircularProgressIndicator(),
              ),
          )
          : RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(
                  order: orders.items[i],
                ),
              ),
          ),
    );
  }
}

Future<void> _refreshOrders(BuildContext context) {
    /* funcao p dar refresh na pagina chamando o metodo loadproducts */
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }
