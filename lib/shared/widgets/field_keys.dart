import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldKey extends StatelessWidget {
  final String label;
  final ValueChanged onChanged;
  FieldKey({required this.label, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(label, style: AppTextStyles.roboto30Black),
          SizedBox(width: 10),
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      color: Colors.black.withOpacity(.25))
                ]),
            child: TextFormField(
              validator: (value) =>
                  Validators().validatorNotEmpty(value: value),
              onChanged: (value) => onChanged(value),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(bottom: 8, left: 8, right: 8)),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4)
              ],
            ),
          )
        ],
      ),
    );
  }
}
