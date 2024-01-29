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

### Single Select Dropdown

    DigitDropdown<int>(
        onChange: (String value, String index) => {},
        textEditingController: TextEditingController(),
        items: const [
            DropdownItem(name: 'first',code: '1',),
            DropdownItem(name: 'second',code: '2',),
            DropdownItem(name: 'third',code: '3',),
            DropdownItem(name: 'fourth',code: '4',
            ),
        ],
    ),

With description and profile Image

    DigitDropdown<int>(
        onChange: (String value, String index) => {},
        textEditingController: TextEditingController(),
        items: const [
            DropdownItem(
                name: 'first',
                code: '1',
                description: 'description for first one',
                profileImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                ),
            ),
            DropdownItem(
                name: 'second',
                code: '2',
                description: 'description for second one',
                profileImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                ),
            ),
            DropdownItem(
                name: 'third',
                code: '3',
                description: 'description for third one',
                profileImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                ),
            ),
            DropdownItem(
                name: 'fourth',
                code: '4',
                description: 'description for fourth one',
                profileImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                ),
            ),
        ],
    ),

With Different Type of Options

    DigitDropdown<int>(
        onChange: (String value, String index) => {},
        textEditingController: TextEditingController(),
        dropdownType: DropdownType.nestedSelect,
        items: const [
            DropdownItem(name: 'first',code: '1',type: 'Type A',),
            DropdownItem(name: 'second',code: '2',type: 'Type B'),
            DropdownItem(name: 'third',code: '3',type: 'Type A',),
            DropdownItem(name: 'fourth',code: '4',type: 'Type B'),
        ],
    ),

### Multi Select Dropdown

    MultiSelectDropDown<int>(
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
            DropdownItem(code: '1', name: 'first'),
            DropdownItem(code: '2', name: 'second'),
            DropdownItem(code: '3', name: 'third'),
            DropdownItem(code: '4', name: 'four'),
        ],
),

### Tree Select Dropdown

Single Select Option

    TreeSelectDropDown<int>(
        onOptionSelected: (List<TreeNode> selectedOptions) {},
        options: [
            TreeNode('C', 'C', [
                TreeNode('C.C1', 'C1', []),
                TreeNode('C.C2', 'C2', []),
            ]),
            TreeNode('D', 'D', [
                TreeNode('D.D1', 'D1', []),
                TreeNode('D.D2', 'D2', []),
            ]),
        ],
        controller: TreeSelectController(),
    ),

Multi Select Option

    TreeSelectDropDown<int>(
        onOptionSelected: (List<TreeNode> selectedOptions) {},
        options: [
            TreeNode('C', 'C', [
                TreeNode('C.C1', 'C1', []),
                TreeNode('C.C2', 'C2', []),
            ]),
            TreeNode('D', 'D', [
                TreeNode('D.D1', 'D1', []),
                TreeNode('D.D2', 'D2', []),
            ]),
        ],
        treeSelectionType: TreeSelectionType.MultiSelect,
        controller: TreeSelectController(),
    ),





## License

[MIT](https://choosealicense.com/licenses/mit/)

![Logo](https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-white-logo.png)