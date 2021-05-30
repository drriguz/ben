import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

final FormFieldValidator<String> mandatoryValidator = (value) {
  if (value!.isEmpty) {
    return S.current.tip_mandatory;
  }
  return null;
};

class TextInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? name;
  final String? hint;
  final int? maxLength;
  final bool mandatory;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const TextInput({
    Key? key,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.name,
    this.hint,
    this.maxLength,
    this.mandatory = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormFieldValidator<String>? mergedValidator = validator;
    if (mandatory) {
      if (mergedValidator == null)
        mergedValidator = mandatoryValidator;
      else {
        mergedValidator = (text) {
          String? result = mandatoryValidator(text);
          if (result != null) return result;
          return validator!(text);
        };
      }
    }

    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLength: maxLength,
      validator: mergedValidator,
      controller: controller,
      decoration: InputDecoration(
        labelText: name,
        helperText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
