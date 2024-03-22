# digit ui components

# Flutter Common UI Widgets

Digit UI Components is a collection of common Flutter widgets designed to simplify UI development. These components offer easy-to-use and customizable features to enhance UI design and streamline the development process.

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  digit_ui_components: 1.0.0
```

Then run:

```bash
   flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
   import 'package:digit_components/digit_components.dart';
```

## Example

### Text Input Variants
Digit UI Components includes various text input fields with optional features such as character count display, inner labels, and help text. These fields also come with built-in validation support for improved data integrity.

#### Text Input Field

        DigitTextFormInput(
            label: "Text Field",
            initialValue: 'value',
            controller: TextEditingController(),
            innerLabel: 'label',
            helpText: 'help text',
            charCount: true,
        );

![text-field](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/613d8da2-33a9-4342-9d8e-a25c83199bb3)

#### Date Input Field

        DigitDateFormInput(
            label: "Date Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        );

![date-field-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/7e291aac-b0dd-4de8-b1dc-d2f1f592b2f3)

![date](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/127411f3-92ec-44a5-9cf3-12e59b4694e3)

![date-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/ef44253a-076a-43d9-b6eb-05b2e440a45b)

#### Time Input Field

        DigitTimeFormInput(
            label: "Time Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        );

![time-field-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/465fcd5d-c0ae-4085-8cf7-16fedd67d3d1)

![time](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/52e809c7-ac53-4778-8980-2a30bdbc87d0)

![time-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/b3a274bd-b90d-4517-a145-57ad968249a5)

#### Location Input Field

        DigitLocationFormInput(
            label: "Location Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        );

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
        );

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
        );

![password-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/5f1cf36d-de98-4759-b7c3-169d5ed10751)

![password-2](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/b7e17a2a-5245-43dd-94ec-3480ce71460e)

#### Search Input Field

        DigitSearchFormInput(
            label: "Search Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
            onSuffixTap: (value){},
        );

![search](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/585c0060-0a5c-44ab-a08b-927b07eb594d)

#### TextArea Input Field

        DigitTextAreaFormInput(
            label: "Text Area",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
        );

![textArea](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/307cc5a0-87e2-4ca0-bf6e-cdc1d6b26741)

### Button Variants
Digit UI Components provides a variety of buttons with optional suffix and prefix icons, contributing to a cohesive and visually appealing UI.

#### Primary Button

        Button(
            label: 'Primary Button',
            onPressed: () {},
            type: ButtonType.primary,
        );

![primary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/2de133ff-f400-4612-a064-7989730b84a1)

with Suffix Icon

        Button(
            suffixIcon: Icons.add,
            label: 'Primary Button',
            onPressed: () {},
            type: ButtonType.primary,
        );

![primary-button-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/6972ce4b-3bb2-4912-ae6b-784473093601)

#### Secondary Button

        Button(
            label: 'secondary Button',
            onPressed: () {},
            type: ButtonType.secondary,
        );

![secondary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/e07bbfaf-536a-4daf-bca1-4c8d9ff016d4)

#### Tertiary Button

        Button(
            label: 'tertiary Button',
            onPressed: () {},
            type: ButtonType.tertiary,
        );

![tertiary-button](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/b56da9f2-3806-4216-8bbd-d902cc4f94fc)

#### Link

        Button(
            label: 'link',
            onPressed: () {},
            type: ButtonType.link,
        );

![link](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/5424ff0e-142a-4482-9559-bfb83d0ad201)

### Radio Buttons
The Radio Buttons component in Digit UI Components empowers users to make a single selection from a list of options. This intuitive interface provides a smooth user experience with hover and mouse-down effects.

        RadioList(
            onChanged: (value) {},
            groupValue: '1',
            radioButtons: [
                RadioButtonModel(code: '1',name: 'One',),
                RadioButtonModel(code: '2', name: 'Two'),
                RadioButtonModel(code: '3', name: 'Three'),
            ],
        );

![radio](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/23bd8fc9-1c44-485c-861d-cd443cc43661)

### Toggle Buttons
The Toggle Buttons component in Digit UI Components presents a list of interactive toggle buttons, providing users with the ability to select a option. Each button is equipped with callbacks for both mouse-down and hover effects, ensuring a responsive and engaging user interface.

        ToggleList(
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
        );

![toggle-list](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/104898b8-dbd6-423e-94e0-3fe46f820bc9)

### Dropdown Variants
Digit UI Components offers various dropdown menus, including single-select, multi-select, and tree-select options.

#### Single Select Dropdown
The Single Select Dropdown in Digit UI Components provides a dropdown menu for users to make a single selection. This intuitive component supports options with additional features such as images, icons, and descriptions, complemented by hover and mouse-down effects.

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
    );

![simple-dropdown](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/4530a905-25aa-494c-ad48-ed9c50f5bf78)

![simple-dropdown-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/d8e38b5d-ecb6-4d9a-b7d2-f8ae8e5fae6f)

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
    );

![simple-dropdown-variation](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/2236d396-3f5f-476b-97a2-9e66460b5807)

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
    );

![dropdown-type](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/ba7c2ccf-b51c-4784-9a3a-4891bbc996a3)

#### Multi Select Dropdown
The Multi Select Dropdown in Digit UI Components offers a user-friendly interface for selecting multiple options simultaneously. This clean and intuitive component is equipped with built-in chips and provides responsive mouse-down and hover effects.

    MultiSelectDropDown<int>(
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
            DropdownItem(code: '1', name: 'first'),
            DropdownItem(code: '2', name: 'second'),
            DropdownItem(code: '3', name: 'third'),
            DropdownItem(code: '4', name: 'four'),
        ],
    );

![multiselect](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/2cd90fe3-ce0e-4c32-b186-9b48c1470171)

![multiselect-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/e100de0e-8fb8-463e-b58d-ff441f7b9721)


#### Tree Select Dropdown
A hierarchical dropdown menu enabling single or multiple selections from a tree-like structure.

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
    );

![tree-select](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/aa11f73e-5e9e-4cc8-a571-5e2695e56378)

![tree-select-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/e05f1846-d10d-471c-b4c2-f1a4831e71e7)

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
    );

![tree-multiselect](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/183ec3fa-34fd-428d-a19c-66735a65ad0b)

![tree-multiselect-1](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/dd793878-c807-40d6-beda-d349e0a0bfc7)


### Toast
The toast component is used for displaying toast messages with various types such as success, error, and warning.

Success toast

        Toast.show(context,
                          options: ToastOptions(
                              "Your Warning message", ToastType.success));

![Screenshot from 2024-03-11 14-32-23](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/51d227a9-1adb-4bc7-a945-bb0b320bef50)



error toast

        Toast.show(context,
                        options: ToastOptions(
                            "Your Warning message", ToastType.error));

![Screenshot from 2024-03-11 14-32-28](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/fc9734cd-3ef5-406b-bc74-9fe2d74670ee)


Warning toast

        Toast.show(context,
                            options: ToastOptions(
                                "Your Warning message", ToastType.warning));


![Screenshot from 2024-03-11 14-32-34](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/f1e4d9c5-d465-4c4e-83eb-513d9767a10c)


### Info Card 
InfoCard is a versatile widget designed to showcase informational content in a visually appealing manner. It is commonly used to display messages, alerts, or other important information. The card supports various customization options to adapt to different use cases.

Info card

        InfoCard(
                  title: 'Info',
                  type: InfoType.info,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),

![Screenshot from 2024-03-11 14-39-56](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/6b73f9ba-44ec-433a-b789-a6b75f9fb28d)


Success card

        InfoCard(
                  title: 'Success',
                  type: InfoType.success,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),

![Screenshot from 2024-03-11 14-40-34](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/49a8f592-702e-4559-a230-f925c9b3851b)


Warning card

       InfoCard(
                  title: 'Warning',
                  type: InfoType.warning,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),

![Screenshot from 2024-03-11 14-41-10](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/3296bcbd-98dc-4e29-a64d-f921499fa30e)


Error card

        InfoCard(
                title: 'Error',
                type: InfoType.error,
                description:
                'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),

![Screenshot from 2024-03-11 14-40-57](https://github.com/egovernments/DIGIT-UI-LIBRARIES/assets/137176770/7b43c6c5-ac91-485a-880a-b4c0b2e28b11)



## License

[MIT](https://choosealicense.com/licenses/mit/)

![Logo](https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-lightPaperPrimary-logo.png)
