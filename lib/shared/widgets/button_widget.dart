import 'package:cryptography_rsa/core/core.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final double paddingHeight;
  final double paddingWidht;
  double opacity = 1;
  IconData? icon;

  ButtonWidget.shared(
      {this.label = 'SALVAR ARQUIVO',
      this.paddingHeight = 18,
      this.paddingWidht = 85});
  ButtonWidget.sideBar(
      {required this.label,
      this.paddingHeight = 25,
      this.paddingWidht = 60,
      this.opacity = 1,
      required this.icon});
  ButtonWidget.selectArchive(
      {this.label = 'SELECIONAR ARQUIVO',
      this.paddingHeight = 12,
      this.paddingWidht = 36});

  ButtonWidget.encryptDecrypt(
      {required this.label, this.paddingHeight = 10, this.paddingWidht = 10});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.paddingWidht, vertical: widget.paddingHeight),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: AppColors.button.withOpacity(widget.opacity)),
      child: Row(
        mainAxisAlignment: widget.icon == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.icon != null,
            child: Row(children: [
              Icon(widget.icon, color: AppColors.iconColor),
              SizedBox(width: 30),
            ]),
          ),
          Text(
            widget.label.toUpperCase(),
            style: AppTextStyles.roboto20White,
          )
        ],
      ),
    );
  }
}
