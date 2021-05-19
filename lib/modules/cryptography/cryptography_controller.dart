import 'dart:convert';
import 'package:cryptography_rsa/shared/widgets/model/cryptography.dart';
import 'package:cryptography_rsa/shared/widgets/model/map_alphabet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show AnchorElement;

class CryptographyController extends ChangeNotifier with Cryptography {
  var textControllerE = TextEditingController();
  var textControllerN = TextEditingController();
  var textControllerMessage = TextEditingController();

  get keyE => int.parse(textControllerE.text);
  get keyN => int.parse(textControllerN.text);

  var keyD;

  String _path = '';
  String _extensionFile = '';
  String _dataEncrypted = '';

  FilePickerResult? file;

  String message = '';
  String get path => _path;
  String get dataEncrypted => _dataEncrypted;

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

  void extractTextOfFile() {
    try {
      if (file?.files.single != null) {
        message = utf8.decode(file!.files.single.bytes!);
        message = message.toUpperCase();
        print('MENSAGEM: $message');
      }
    } catch (e) {
      print('ERRO: $e');
    }
  }

  void encrypt() {
    try {
      if (textControllerMessage.text.isEmpty)
        extractTextOfFile();
      else
        message = textControllerMessage.text.toUpperCase();

      var messageEncrypted = <int>[];
      for (var i = 0; i < message.length; i++) {
        MapAlphabet.mapAlphabet.forEach((String key, value) {
          if (key == (message[i])) {
            messageEncrypted.add(encryptChar(
                char: value, e: int.parse(textControllerE.text), n: keyN));
          }
        });
      }

      _dataEncrypted = messageEncrypted.toString();

      notifyListeners();
    } catch (e) {
      print('ERRO: $e');
    }
  }

  void saveFile() {
    try {
      if (dataEncrypted.isNotEmpty) {
        String filename = 'Dado_criptografado.txt';

        AnchorElement()
          ..href =
              '${Uri.dataFromString(dataEncrypted, mimeType: 'text/plain', encoding: utf8)}'
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

    //CAMPOS E ou N VAZIO
    if (textControllerE.text.isEmpty)
      messageErro = 'Preencha o campo E';
    else if (textControllerN.text.isEmpty)
      messageErro = 'Preencha o campo N';
    // //QUANDO NAO FOREM PRIMOS
    // else if (!validationEN(e: keyE, n: keyN))
    //   messageErro = 'Campo E ou N não é primo.';
    //CAMPO TEXTO/FILE
    else if (textControllerMessage.text.isEmpty && file?.files.single == null)
      messageErro = 'Preencha o campo TEXTO ou adicione um arquivo';
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messageErro)));
  }
}
