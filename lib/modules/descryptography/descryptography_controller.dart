import 'dart:convert';
import 'package:cryptography_rsa/shared/widgets/model/cryptography.dart';
import 'package:cryptography_rsa/shared/widgets/model/map_alphabet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show AnchorElement;

class DescryptographyController extends ChangeNotifier with Cryptography {
  var textControllerP = TextEditingController();
  var textControllerQ = TextEditingController();
  var textControllerE = TextEditingController();
  var textControllerMessage = TextEditingController();

  get keyP => int.parse(textControllerP.text);
  get keyQ => int.parse(textControllerQ.text);
  get keyE => int.parse(textControllerE.text);

  var keyD;
  late var keyN =
      int.parse(textControllerP.text) * int.parse(textControllerQ.text);

  String _path = '';
  String _extensionFile = '';
  String _dataDecrypted = '';

  FilePickerResult? file;

  List<int> message = [];
  String get path => _path;
  String get dataDecrypted => _dataDecrypted;

  Future selectFile() async {
    try {
      file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if (file?.files.single != null) {
        _extensionFile = file!.files.single.extension!;
        String fileContent = utf8.decode(file!.files.single.bytes!);
        print('DADOS: $fileContent');
        _path = file!.files.single.name!;
        notifyListeners();
      } else {
        throw "Cancelled File Picker";
      }
    } catch (e) {
      print('ERRO: $e');
    }
  }

  void messageStringToList() {
    String messageAux;
    try {
      if (textControllerMessage.text.isNotEmpty)
        messageAux = textControllerMessage.text;
      else
        messageAux = extractTextOfFile();

      print('mensagem aux: $messageAux');

      if (messageAux.isNotEmpty) {
        //limpa lista para nao ficar concatenando com resultado anterior.
        message.clear();
        var auxMessage = messageAux.replaceAll(RegExp("\\["), '');
        auxMessage = auxMessage.replaceAll(RegExp("\\]"), '');

        auxMessage
            .split(',')
            .map((value) => message.add(int.parse(value)))
            .toList();

        print('lista int: $message');
      }
    } catch (e) {
      print('ERRO ao converter String para List<int>: $e');
    }
  }

  String extractTextOfFile() {
    if (file?.files.single != null) {
      String messageByte = utf8.decode(file!.files.single.bytes!);
      print('MENSAGEM: $message');

      return messageByte;
    } else
      return '';
  }

  void decrypt() {
    try {
      messageStringToList();

      keyD = generateD(
          p: int.parse(textControllerP.text),
          q: int.parse(textControllerQ.text),
          e: int.parse(textControllerE.text));

      if (keyD != null) {
        for (var i = 0; i < message.length; i++) {
          var ref = encryptChar(char: message[i], e: keyD, n: keyN);
          MapAlphabet.mapAlphabet.forEach((String key, value) {
            if (value == ref) {
              _dataDecrypted += key;
            }
          });
        }
      }
      print('MENSAGEM DESCRIPTOGRAFADA: $_dataDecrypted');
      notifyListeners();
    } catch (e) {
      print('ERRO: $e');
    }
  }

  void saveFile() {
    try {
      if (dataDecrypted.isNotEmpty) {
        String filename = 'Dado_descriptografado.txt';

        AnchorElement()
          ..href =
              '${Uri.dataFromString(dataDecrypted, mimeType: 'text/plain', encoding: utf8)}'
          ..download = filename
          ..style.display = 'none'
          ..click();
      }
    } catch (e) {
      print('ERRO to save file: $e');
    }
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
    //CAMPO TEXTO/FILE
    else if (textControllerMessage.text.isEmpty && file?.files.single == null)
      messageErro = 'Preencha o campo TEXTO ou adicione um arquivo';
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messageErro)));
  }
}
