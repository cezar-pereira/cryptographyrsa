import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/modules/generate_key/generate_key_controller.dart';
import 'package:cryptography_rsa/shared/widgets/button_widget.dart';
import 'package:cryptography_rsa/shared/widgets/field_keys.dart';

import 'package:flutter/material.dart';

class GenerateKeyPage extends StatefulWidget {
  @override
  _GenerateKeyPageState createState() => _GenerateKeyPageState();
}

class _GenerateKeyPageState extends State<GenerateKeyPage> {
  late GenerateKeyController _controller;
  late var _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _controller = GenerateKeyController();
  }

  bool _validations() {
    if ((_formKey.currentState!.validate()) &&
        (_controller.validationPQ(p: _controller.keyP, q: _controller.keyQ))) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.only(top: 140),
        padding: const EdgeInsets.only(right: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FieldKey(
                    label: 'P',
                    onChanged: (value) =>
                        _controller.textControllerP.text = value),
                FieldKey(
                    label: 'Q',
                    onChanged: (value) =>
                        _controller.textControllerQ.text = value),
                FieldKey(
                    label: 'E',
                    onChanged: (value) =>
                        _controller.textControllerE.text = value),
              ],
            ),
            if (_controller.publicKey != '')
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  child: Column(
                    children: [
                      Text('CHAVES', style: AppTextStyles.roboto30Black),
                      SizedBox(height: 8),
                      Text(_controller.publicKey,
                          style: AppTextStyles.roboto25Black),
                    ],
                  ),
                ),
              ),
            InkWell(
              onTap: () {
                if (_validations()) {
                  setState(() {
                    _controller.generateKey();
                  });
                } else
                  _controller.buildMessageErro(context: context);
              },
              child: Container(
                  width: 380,
                  margin: const EdgeInsets.only(top: 60),
                  child: ButtonWidget.encryptDecrypt(label: 'GERAR CHAVES')),
            ),
          ],
        ),
      ),
    );
  }
}
