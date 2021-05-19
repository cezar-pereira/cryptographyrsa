class Validators {
  validatorNotEmpty({required String? value}) => value!.isNotEmpty ? null : '';
}
