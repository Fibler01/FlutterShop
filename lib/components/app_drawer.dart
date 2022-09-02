import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key); /* Para fazer o "hamburguer" do lado esquerdo */

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Loja'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              },
            )
          
        ],
      ),
    );
  }
}
