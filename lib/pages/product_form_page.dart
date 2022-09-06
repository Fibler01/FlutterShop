import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            /* criando formulario */
            child: ListView(
          children: [
            TextFormField(
              /* campo do formulario */
              decoration: InputDecoration(labelText: 'Nome'),
              /* estilo floating label no ionic */
              textInputAction: TextInputAction.next,
              /* para o botao de concluido ir p o próximo input ao inves de enviar o formulario (IMPORTANTE) */
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(
                    _priceFocus); /* chamando foco para o elemento _priceFocus */
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Preço'),
              textInputAction: TextInputAction.next,
              focusNode: _priceFocus,
              /* falando que aponta para o pricefocus, vinculando-o ao textformfield */
              keyboardType: TextInputType.numberWithOptions(
                decimal: true, /* para funcionar no IOS */
              ),
              /* DEFININDO TIPO DO TECLADO DO INPUT */
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descrição'),
              focusNode: _descriptionFocus,
              keyboardType: TextInputType.multiline,
              /* para um campo com quantidade de linhas maior */
              maxLines: 3,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  /* para url voltar a aparecer */
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Url da Imagem'),
                    focusNode: _imageUrlFocus,
                    controller: _imageUrlController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
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
                  child: _imageUrlController.text.isEmpty  /* se controller estiver vazio mostra texto de informar URL, se nao, mostra a imagem qual o link esta escrito */
                      ? const Text('Informe a Url')
                      : FittedBox(
                          child: Image.network(_imageUrlController.text),
                          fit: BoxFit.cover,
                        ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
