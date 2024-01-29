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

### Text Input Variants

#### Text Input Field

        DigitTextFormInput(
            label: "Text Field",
            initialValue: 'value',
            controller: TextEditingController(),
            innerLabel: 'label',
            helpText: 'help text',
            charCount: true,
        )
        
        ![text-field](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/613d8da2-33a9-4342-9d8e-a25c83199bb3)

#### Date Input Field

        DigitDateFormInput(
            label: "Date Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

![date-field-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/7e291aac-b0dd-4de8-b1dc-d2f1f592b2f3)
     
![date-field-2](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/89cb85e6-b941-4944-a3df-a27c51d58a67)  

#### Time Input Field

        DigitTimeFormInput(
            label: "Time Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

![time-field-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/465fcd5d-c0ae-4085-8cf7-16fedd67d3d1)

![time-field-2](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/5011ecfb-46b4-4085-bc29-1cc85e098c54)


#### Location Input Field

        DigitLocationFormInput(
            label: "Location Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

![location](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/1619fb97-57dc-45bc-b249-4a626e53a8f5)

![location-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/3f013759-45d9-4b33-b581-0e8a9d70139b)

##### Numeric Input Field

        DigitNumericFormInput(
            label: "Numeric Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
            initialValue: '0',
            step: 1,
        ),

![numeric](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/4f3e5510-c58a-46ba-8e38-3f4c28d71953)

#### Password Input Field

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

![password-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/5f1cf36d-de98-4759-b7c3-169d5ed10751)

![password-2](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/b7e17a2a-5245-43dd-94ec-3480ce71460e)

#### Search Input Field

        DigitSearchFormInput(
            label: "Search Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
            onSuffixTap: (value){},
        ),

![search](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/585c0060-0a5c-44ab-a08b-927b07eb594d)

#### TextArea Input Field

        DigitTextAreaFormInput(
            label: "Text Area",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        ),

  ![textArea](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/307cc5a0-87e2-4ca0-bf6e-cdc1d6b26741)

### Button Variants

#### Primary Button

        DigitButton(
            label: 'Primary Button',
            onPressed: () {},
            type: ButtonType.primary,
        ),

  ![primary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/2de133ff-f400-4612-a064-7989730b84a1)

with Suffix Icon

        DigitButton(
            suffixIcon: Icons.add,
            label: 'Primary Button',
            onPressed: () {},
            type: ButtonType.primary,
        ),

  ![primary-button-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/6972ce4b-3bb2-4912-ae6b-784473093601)

#### Secondary Button

        DigitButton(
            label: 'secondary Button',
            onPressed: () {},
            type: ButtonType.secondary,
        ),

  ![secondary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/e07bbfaf-536a-4daf-bca1-4c8d9ff016d4)

#### Tertiary Button

        DigitButton(
            label: 'tertiary Button',
            onPressed: () {},
            type: ButtonType.tertiary,
        ),

![tertiary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/b56da9f2-3806-4216-8bbd-d902cc4f94fc)

#### Link

        DigitButton(
            label: 'link',
            onPressed: () {},
            type: ButtonType.link,
        ),

![link](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/5424ff0e-142a-4482-9559-bfb83d0ad201)

### Radio Buttons

        DigitRadioList(
            onChanged: (value) {},
            groupValue: '1',
            radioButtons: [
                RadioButtonModel(code: '1',name: 'One',),
                RadioButtonModel(code: '2', name: 'Two'),
                RadioButtonModel(code: '3', name: 'Three'),
            ],
        ),

  ![radio](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/23bd8fc9-1c44-485c-861d-cd443cc43661)

### Toggle Buttons

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

  ![toggle-list](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/104898b8-dbd6-423e-94e0-3fe46f820bc9)

### Dropdown Variants

#### Single Select Dropdown

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

#### Multi Select Dropdown

    MultiSelectDropDown<int>(
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
            DropdownItem(code: '1', name: 'first'),
            DropdownItem(code: '2', name: 'second'),
            DropdownItem(code: '3', name: 'third'),
            DropdownItem(code: '4', name: 'four'),
        ],
),

#### Tree Select Dropdown

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
