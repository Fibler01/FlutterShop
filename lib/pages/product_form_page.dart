import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey =
      GlobalKey<FormState>(); /* definindo um globalkey para o formulario */
  final _formData = Map<String,
      Object>(); /* criando um map de string e objeto, onde strings sao nome, preco, descricao, etc, e objetos o que foi colocado pelo user */

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)
          ?.settings
          .arguments; /* pegando argumentos da rota para ver se veio de editar produto ou adicionar produto */

      if (arg != null) {
        /* se tiver argumentos é pq esta vindo de uma tela de edicao, logo, 'e carregado os valores do produto no formulario */
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    /* para liberar recursos caso essa tela seja liberada também */
    super.dispose;
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    /* atualizando estado p mostrar imagem a partir da url */
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ??
        false; /* verificando se url existe */
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    /* aplicando validacao da url se termina com png, jpg ou jpeg */
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return; /* se nao for valido nao manda produto p o banco */
    }

    _formKey.currentState
        ?.save(); /* faz a chamada de cada um dos campos do onsaved */

    print(_formData
        .values); /* printando os dados colocados pelo usuario ao dar submit */
    /* criando novo produto */
    /* listen = false p chamar o provider fora do build */

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData);
        Navigator.of(context).pop(); /* voltando p tela anterior, tirando essa tela do topo da pilha*/
    } catch(error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text('Ocorreu um erro ao salvar o produto.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        ),
      );
      
    } finally {/* finnaly executa mesmo se houver erro ou se for de forma bem sucedida */
      setState(() {
        _isLoading = false; /* parando carregamento apos salvar produto */
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), /* se esta carregando mostra o progress indicator, se não mostra o resto da tela */
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _formKey,
                  /* a partir desse formkey é possivel ter acesso no submitform */
                  /* criando formulario */
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        /* pegando valor caso venha da edição, caso venha da criacao, recebe vazio */
                        /* campo do formulario */
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          /* é possivel adicionar errortext p personalizar a validacao */
                        ),
                        /* estilo floating label no ionic */
                        textInputAction: TextInputAction.next,
                        /* para o botao de concluido ir p o próximo input ao inves de enviar o formulario (IMPORTANTE) */
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(
                              _priceFocus); /* chamando foco para o elemento _priceFocus */
                        },
                        onSaved: (name) => _formData['name'] = name ?? '',
                        /* salvando o nome ao clicar em submit */
                        validator: (_name) {
                          /* aplicando validacoes */
                          final name = _name ?? '';

                          if (name.trim().isEmpty) {
                            /* se nome for vazio */
                            return 'Nome é obrigatório';
                          }

                          if (name.trim().length < 3) {
                            return 'Nome precisa no mínimo de 3 letras.';
                          }

                          return null; /* se retornar nulo significa que o campo foi validado com sucesso, se retornar string, mostrara o erro p usuario*/
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        /* falando que aponta para o pricefocus, vinculando-o ao textformfield */
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true, /* para funcionar no IOS */
                        ),
                        /* DEFININDO TIPO DO TECLADO DO INPUT */
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0'),
                        validator: (_price) {
                          final priceString = _price ?? '-1';
                          final price = double.tryParse(priceString) ?? -1;
                          /* adicionar para caso price esteja com , converte-lo para . */
                          if (price <= 0) {
                            return 'Informe um preço válido.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: InputDecoration(labelText: 'Descrição'),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        /* para um campo com quantidade de linhas maior */
                        maxLines: 3,
                        onSaved: (description) =>
                            _formData['description'] = description ?? '',
                        validator: (_description) {
                          /* aplicando validacoes */
                          final description = _description ?? '';

                          if (description.trim().isEmpty) {
                            /* se nome for vazio */
                            return 'Descrição é obrigatória';
                          }

                          if (description.trim().length < 5) {
                            return 'Descrição precisa no mínimo de 5 letras.';
                          }

                          return null; /* se retornar nulo significa que o campo foi validado com sucesso, se retornar string, mostrara o erro p usuario*/
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            /* para url voltar a aparecer */
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Url da Imagem'),
                              focusNode: _imageUrlFocus,
                              controller: _imageUrlController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              onFieldSubmitted: (_) => _submitForm(),
                              validator: (_imageUrl) {
                                final imageUrl = _imageUrl ?? '';
                                if (!isValidImageUrl(imageUrl)) {
                                  return 'Informe uma Url válida!';
                                }

                                return null;
                              }, /* submetendo form */
                              /* para um campo com quantidade de linhas maior */
                            ),
                          ),
                          Container(
                            /* responsavel por mostrar a imagem do url */
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: _imageUrlController.text
                                    .isEmpty /* se controller estiver vazio mostra texto de informar URL, se nao, mostra a imagem qual o link esta escrito */
                                ? const Text('Informe a Url')
                                : Image.network(_imageUrlController.text),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
