import 'package:flutter/material.dart';

import '../providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo Contador'),
      ),
      body: Column(
        children: [
          Text(provider?.state.value.toString() ?? '0'),  /* permite o acesso desse componente em qualquer componente, por ser inherit */
          IconButton(
            onPressed: () {
              setState(() {
                provider?.state.inc();
              print(provider?.state.value);
              });
              
            },
            icon: Icon(Icons.add),
          ),
          IconButton(onPressed: () {
            setState(() {
              provider?.state.dec();
            print(provider?.state.value);
            });
            
          }, icon: Icon(Icons.remove))
        ],
      ),
    );
  }
}
