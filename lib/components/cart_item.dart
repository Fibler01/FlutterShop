import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      /* trabalhando com a exclusão de itens do carrinho, deslizando p excluir */
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          /* para ter exatamente a posição do card */
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (_) {
        /* pedindo a confirmação da exclusão */
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem Certeza?'),
            content: Text('Deseja remover o item do carrinho?'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(ctx).pop(false); /* passando contexto recebido como resposta do alertdialog */
              }, child: Text('Não')),
              TextButton(onPressed: () {
                Navigator.of(ctx).pop(true); /* retorna verdade caso sim */
              }, child: Text('Sim')),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          /* deixando os cards mais bonitos */
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(
              cartItem.name,
            ),
            subtitle: Text(
                'Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            /* mostrando p cada produto o preço vs quantidade */
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
