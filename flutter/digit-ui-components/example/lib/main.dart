import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Define the form group
  final FormGroup form = FormGroup({
    'customField': FormControl<String>(value: '', validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveWrapperField<String>(
                formControlName: 'customField',
                validationMessages: {
                  'required': (error) => 'This field is required',
                },
                showErrors: (control) => control.invalid && control.touched,
                builder: (field) {
                  // Extra logging to debug
                  print('Field touched: ${field.control.touched}');
                  print('Field valid: ${field.control.valid}');
                  print('Field errorText: ${field.errorText}');

                  return BaseDigitFormInput(
                   onTap : () {
                     print('ttttttttttttttttttttttttttttttt');
                      // Mark the control as touched when the field is tapped
                      field.control.markAsTouched();
                    },
                    errorMessage: field.errorText,
                    onChange: (value) {
                      field.didChange(value);
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Button(
                size: ButtonSize.large,
                type: ButtonType.primary,
                label: 'Submit',
                onPressed: () {
                  if (form.valid) {
                    // Get the value of the custom field
                    print('Custom Field Value: ${form.control('customField').value}');
                  } else {
                    form.markAllAsTouched();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}