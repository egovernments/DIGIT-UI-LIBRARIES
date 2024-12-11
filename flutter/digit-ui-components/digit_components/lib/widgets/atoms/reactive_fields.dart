import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveWrapperField<T> extends ReactiveFormField<T, T> {
  final Widget Function(ReactiveFormFieldState) builder;

  ReactiveWrapperField({
    Key? key,
    required String formControlName,
    required this.builder,
    Map<String, ValidationMessageFunction>? validationMessages,
    ShowErrorsFunction? showErrors,
  }) : super(
    key: key,
    formControlName: formControlName,
    validationMessages: validationMessages,
    showErrors: showErrors,
    builder: (field) {
      return builder(field);
    },
  );
}