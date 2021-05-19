import 'package:cryptography_rsa/shared/widgets/model/cryptography.dart';
import 'package:flutter/material.dart';

class GenerateKeyController extends Cryptography {
  var textControllerP = TextEditingController();
  var textControllerQ = TextEditingController();
  var textControllerE = TextEditingController();
  var textControllerMessage = TextEditingController();

  get keyP => int.parse(textControllerP.text);
  get keyQ => int.parse(textControllerQ.text);
  get keyE => int.parse(textControllerE.text);

  String _publicKey = '';

  String get publicKey => _publicKey;

  void generateKey() {
    int keyN = keyP * keyQ;
    _publicKey = 'E: $keyE    N: $keyN';
  }

  buildMessageErro({context}) {
    String messageErro = 'ERRO';

    //CAMPOS P,Q OU E VAZIO
    if (textControllerP.text.isEmpty)
      messageErro = 'Preencha o campo P';
    else if (textControllerQ.text.isEmpty)
      messageErro = 'Preencha o campo Q';
    else if (textControllerE.text.isEmpty)
      messageErro = 'Preencha o campo E';
    //QUANDO NAO FOREM PRIMOS
    else if (!validationPQ(p: keyP, q: keyQ))
      messageErro = 'Campo P, Q ou E não é primo.';

    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messageErro)));
  }
}
