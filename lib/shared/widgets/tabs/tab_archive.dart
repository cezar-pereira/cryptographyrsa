import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'tab_box.dart';

class TabArchive extends StatelessWidget {
  final String path;
  final VoidCallback onTap;

  TabArchive({required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TabBox(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Arquivo: ', style: AppTextStyles.roboto20Black),
              Text(path, style: AppTextStyles.roboto20Black),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(width: 280, child: ButtonWidget.selectArchive()),
          )
        ],
      ),
    ));
  }
}
