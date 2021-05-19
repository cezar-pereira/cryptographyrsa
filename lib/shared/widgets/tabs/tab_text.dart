import 'package:cryptography_rsa/core/core.dart';
import 'package:flutter/material.dart';

import 'tab_box.dart';

class TabText extends StatelessWidget {
  final ValueChanged onChanged;
  TabText({required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TabBox(
      child: Container(
        child: TextFormField(
          onChanged: (value) => onChanged(value),
          style: AppTextStyles.roboto20Black,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
