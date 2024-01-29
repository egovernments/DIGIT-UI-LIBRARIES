# digit ui components

# Flutter Common UI Widgets

A collection of common widgets for Flutter, designed to streamline UI development by providing
easy-to-use and customizable components.

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  your_package_name: ^1.0.0
```

Then run:

```bash
   flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
   import 'package:digit-ui-components/digit_components/digit_components.dart';
```

## Example

## Text Input Variants

### Text Input Field

        DigitTextFormInput(
            label: "Text Field",
            initialValue: 'value',
            controller: TextEditingController(),
            innerLabel: 'label',
            helpText: 'help text',
            charCount: true,
        )

### Date Input Field

        DigitDateFormInput(
            label: "Date Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

### Time Input Field

        DigitTimeFormInput(
            label: "Time Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

### Location Input Field

        DigitLocationFormInput(
            label: "Location Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

### Numeric Input Field

        DigitNumericFormInput(
            label: "Numeric Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
            initialValue: '0',
            step: 1,
        ),

### Password Input Field

        DigitPasswordFormInput(
            label: "password Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
            validations: [
                Validator(ValidatorType.minLength, 6,
                errorMessage:
                'Password must be at least 6 characters.'),
            ],
        ),

### Search Input Field

        DigitSearchFormInput(
            label: "Search Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

### TextArea Input Field

        DigitTextAreaFormInput(
            label: "Text Area",
            controller: TextEditingController(),
            innerLabel: 'label',
            helpText: 'help text',
        ),

## Button Variants

### Primary Button

        DigitButton(
            label: 'p',
            onPressed: () {},
            type: ButtonType.primary,
        ),

with Suffix Icon

        DigitButton(
            suffixIcon: Icons.add,
            label: 'p',
            onPressed: () {},
            type: ButtonType.primary,
        ),

### Secondary Button

        DigitButton(
            label: 'secondary Button',
            onPressed: () {},
            type: ButtonType.secondary,
        ),

with Suffix Icon

        DigitButton(
            suffixIcon: Icons.arrow_forward,
            label: 'secondary Button',
            onPressed: () {},
            type: ButtonType.secondary,
        ),

### Tertiary Button

        DigitButton(
            label: 'tertiary Button',
            onPressed: () {},
            type: ButtonType.tertiary,
        ),

### Link

        DigitButton(
            label: 'link',
            onPressed: () {},
            type: ButtonType.link,
        ),

## Radio Buttons

        DigitRadioList(
            onChanged: (value) {},
            radioButtons: [
                RadioButtonModel(code: '1',name: 'One',),
                RadioButtonModel(code: '2', name: 'Two'),
                RadioButtonModel(code: '3', name: 'Three'),
            ],
        ),

## Toggle Buttons

        DigitToggleList(
            toggleButtons: [
                ToggleButtonModel(
                    name: 'Toggle 1', key: 'key1', onSelected: (value) {}),
                ToggleButtonModel(
                    name: 'Toggle 2', key: 'key2', onSelected: (value) {}),
                ToggleButtonModel(
                    name: 'Toggle 3', key: 'key3', onSelected: (value) {}),
                ],
            selectedIndex: 1,
            onChanged: (selectedValues) {},
        ),

## Dropdown Variants



## License

[MIT](https://choosealicense.com/licenses/mit/)

![Logo](https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-white-logo.png)