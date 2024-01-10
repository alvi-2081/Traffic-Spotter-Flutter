import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as valid;

class Validator {
  static FormFieldValidator emailValidator = valid.MultiValidator([
    valid.RequiredValidator(errorText: "*Required"),
    valid.EmailValidator(errorText: "*Email not Valid")
  ]);
  static FormFieldValidator requiredValidator = valid.MultiValidator([
    valid.RequiredValidator(errorText: "*Required"),
  ]);
}
