import 'package:cryptography_rsa/core/core.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final _textController = TextEditingController();

  TextBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textController.text = text;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: _textController,
        readOnly: true,
        style: AppTextStyles.roboto20Black,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
