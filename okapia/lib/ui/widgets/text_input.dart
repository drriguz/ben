import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

final FormFieldValidator<String> mandatoryValidator = (value) {
  if (value.isEmpty) {
    return S.current.please_input_the_value;
  }
  return null;
};

class TextInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String name;
  final String hint;
  final int maxLength;
  final bool mandatory;
  final bool obscureText;

  const TextInput({
    Key key,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.name,
    this.hint,
    this.maxLength,
    this.mandatory = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormFieldValidator<String> mergedValidator;
    if (mandatory) {
      if (validator == null)
        mergedValidator = mandatoryValidator;
      else
        mergedValidator = (text) {
          String result = mandatoryValidator(text);
          if (result == null) result = validator(text);
          return result;
        };
    }
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLength: maxLength,
      validator: mergedValidator,
      decoration: InputDecoration(
        labelText: name,
        helperText: hint,
      ),
    );
  }
}
