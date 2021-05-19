import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class SideBarWidget extends StatefulWidget {
  final ValueChanged onSelect;
  SideBarWidget({required this.onSelect});

  @override
  _SideBarWidgetState createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  var _barSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
      width: 400,
      decoration: BoxDecoration(
          color: AppColors.sideBar, borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _barSelected = 0;
              });
              widget.onSelect(0);
            },
            child: ButtonWidget.sideBar(
              label: "GERAR CHAVES",
              icon: Icons.vpn_key_outlined,
              opacity: _barSelected == 0 ? 1 : 0,
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              setState(() {
                _barSelected = 1;
              });
              widget.onSelect(1);
            },
            child: ButtonWidget.sideBar(
              label: "CRIPTOGRAFAR",
              icon: Icons.lock_outline,
              opacity: _barSelected == 1 ? 1 : 0,
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              setState(() {
                _barSelected = 2;
              });
              widget.onSelect(2);
            },
            child: ButtonWidget.sideBar(
              label: "DESCRIPTOGRAFAR",
              icon: Icons.lock_open_rounded,
              opacity: _barSelected == 2 ? 1 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
