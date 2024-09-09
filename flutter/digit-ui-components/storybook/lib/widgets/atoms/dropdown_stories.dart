import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/models/TreeModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_multiselect_dropdown.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tree_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> dropdownStories() {
  return [
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/default/default',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            dropdownController: TextEditingController(),
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            items: [
              'one',
              'two',
              'three',
              'four',
            ]
                .asMap()
                .entries
                .map(
                  (item) => DropdownItem(
                name: item.value,
                code: item.key.toString(),
              ),
            )
                .toList(),
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/default/nested text',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            dropdownController: TextEditingController(),
            items: [
              'one',
              'two',
              'three',
              'four',
            ]
                .asMap()
                .entries
                .map(
                  (item) => DropdownItem(
                name: item.value,
                code: item.key.toString(),
                description: 'description for ${item.value} one',
              ),
            )
                .toList(),
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/default/icon',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            dropdownController: TextEditingController(),
            items: [
              'one',
              'two',
              'three',
              'four',
            ]
                .asMap()
                .entries
                .map(
                  (item) => DropdownItem(
                name: item.value,
                code: item.key.toString(),
                textIcon: Icons.article,
              ),
            )
                .toList(),
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/default/profile',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            dropdownController: TextEditingController(),
            items: [
              'one',
              'two',
              'three',
              'four',
            ]
                .asMap()
                .entries
                .map(
                  (item) => DropdownItem(
                name: item.value,
                code: item.key.toString(),
                profileImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
              ),
            ).toList(),
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/nested/simple',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            dropdownController: TextEditingController(),
            selectionType: SelectionType.nestedSelect,
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            items: const [
              DropdownItem(
                name: 'one',
                code: '1',
              ),
              DropdownItem(
                name: 'two',
                code: '2',
                type: 'group A',
              ),
              DropdownItem(
                name: 'three',
                code: '3',
                type: 'group B',
              ),
              DropdownItem(
                name: 'four',
                code: '4',
                type: 'group A',
              ),
              DropdownItem(
                name: 'five',
                code: '4',
                type: 'group B',
              ),
              DropdownItem(
                name: 'six',
                code: '5',
                type: 'group A',
              ),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/nested/nested text',
      builder: (context) => Column(
        children: [
          const SizedBox(height: 300,),
          DigitDropdown<int>(
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
            onSelect: (item) => {},
            dropdownController: TextEditingController(),
            selectionType: SelectionType.nestedSelect,
            isSearchable: context.knobs
                .boolean(label: 'Searchable', initial: false),
            items: const [
              DropdownItem(
                name: 'one',
                code: '1',
                type: 'group B',
                description: 'this is sample description',
              ),
              DropdownItem(
                name: 'two',
                code: '2',
                type: 'group A',
                description: 'this is sample description',
              ),
              DropdownItem(
                name: 'three',
                code: '3',
                type: 'group B',
                description: 'this is sample description',
              ),
              DropdownItem(
                name: 'four',
                code: '4',
                type: 'group A',
                description: 'this is sample description',
              ),
              DropdownItem(
                name: 'five',
                code: '4',
                type: 'group B',
                description: 'this is sample description',
              ),
              DropdownItem(
                name: 'six',
                code: '5',
                type: 'group A',
                description: 'this is sample description',
              ),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/tree',
      builder: (context) => TreeSelectDropDown<int>(
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<TreeNode> selectedOptions) {},
        options: [
          TreeNode('A', 'A', [
            TreeNode('A.A1', 'A1', []),
            TreeNode('A.A2', 'A2', []),
          ]),
          TreeNode('B', 'B', [
            TreeNode('B.B1', 'B1', []),
            TreeNode('B.B2', 'B2', []),
          ]),
          TreeNode('C', 'C', [
            TreeNode('C.C1', 'C1', []),
            TreeNode('C.C2', 'C2', []),
          ]),
          TreeNode('D', 'D', [
            TreeNode('D.D1', 'D1', []),
            TreeNode('D.D2', 'D2', []),
          ]),
        ],
        treeSelectionType: DropdownType.singleSelect,
      ),
    ),
    Story(
      name: 'Atom/Dropdown/Simple Dropdown/default/default',
      builder: (context) => DigitDropdown<int>(
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        onSelect: (item) => {},
        dropdownController: TextEditingController(),
        isSearchable: context.knobs
            .boolean(label: 'Searchable', initial: false),
        items: [
          'one',
          'two',
          'three',
          'four',
        ]
            .asMap()
            .entries
            .map(
              (item) => DropdownItem(
            name: item.value,
            code: item.key.toString(),
          ),
        )
            .toList(),
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/default/default',
      builder: (context) {

        return MultiSelectDropDown<int>(
          showSelectAll: true,
          isSearchable: context.knobs.boolean(
              label: 'Searchable', initial: false),
          isDisabled: context.knobs
              .boolean(label: 'disabled', initial: false),
          onOptionSelected: (List<DropdownItem> selectedOptions) {},
          selectedOptions: const [
            DropdownItem(code: '2', name: 'tonesdffffffffffffffffffffffffwo'),
            DropdownItem(code: '3', name: 'thonesdffffffffffffffffffffffffree'),
          ],
          options: const [
            DropdownItem(code: '1', name: 'onesdfffffffffffffffdsf;jlkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkfffffffff'),
            DropdownItem(code: '2', name: 'tonesdffffffffffffffffffffffffwo'),
            DropdownItem(code: '3', name: 'thonesdffffffffffffffffffffffffree'),
            DropdownItem(code: '4', name: 'fouonesdffffffffffffffffffffffffr'),
            DropdownItem(code: '5', name: 'fivonesdffffffffffffffffffffffffe'),
            DropdownItem(code: '12', name: 'ononesdffffffffffffffffffffffffe'),
            DropdownItem(code: '24', name: 'twonesdffffffffffffffffffffffffo'),
            DropdownItem(code: '333', name: 'thonesdffffffffffffffffffffffffree'),
            DropdownItem(code: '433', name: 'fouonesdffffffffffffffffffffffffr'),
            DropdownItem(code: '53', name: 'fiveonesdffffffffffffffffffffffff'),
            DropdownItem(code: '132', name: 'oneonesdffffffffffffffffffffffff'),
            DropdownItem(code: '2345', name: 'twonesdffffffffffffffffffffffffo'),
            DropdownItem(code: '3453', name: 'thronesdffffffffffffffffffffffffee'),
            DropdownItem(code: '45645', name: 'foonesdffffffffffffffffffffffffur'),
            DropdownItem(code: '5564564', name: 'fionesdffffffffffffffffffffffffve'),
            DropdownItem(code: '165745', name: 'ononesdffffffffffffffffffffffffe'),
            DropdownItem(code: '25645', name: 'twonesdffffffffffffffffffffffffo'),
            DropdownItem(code: '3345345', name: 'tonesdffffffffffffffffffffffffhree'),
            DropdownItem(code: '434534', name: 'foonesdffffffffffffffffffffffffur'),
            DropdownItem(code: '53453', name: 'fivonesdffffffffffffffffffffffffe'),
            DropdownItem(code: '13534', name: 'ononesdffffffffffffffffffffffffe'),
            DropdownItem(code: '223', name: 'twoonesdffffffffffffffffffffffff'),
            DropdownItem(code: '332', name: 'thonesdffffffffffffffffffffffffree'),
            DropdownItem(code: '42', name: 'fouonesdffffffffffffffffffffffffr'),
            DropdownItem(code: '5987', name: 'fivonesdffffffffffffffffffffffffe'),
          ],
        );
      }
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/default/nested text',
      builder: (context) => MultiSelectDropDown<int>(
        isSearchable: context.knobs.boolean(label: 'Searchable', initial: false),
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
          DropdownItem(code: '1', name: 'one',  description: 'description for one',),
          DropdownItem(code: '2', name: 'two',  description: 'description for two',),
          DropdownItem(code: '3', name: 'three', description: 'description for three',),
          DropdownItem(code: '4', name: 'four', description: 'description for four',),
          DropdownItem(code: '5', name: 'five', description: 'description for five',),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/default/icon',
      builder: (context) => MultiSelectDropDown<int>(
        isSearchable: context.knobs.boolean(label: 'Searchable', initial: false),
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
          DropdownItem(code: '1', name: 'one', textIcon: Icons.article),
          DropdownItem(code: '2', name: 'two', textIcon: Icons.article),
          DropdownItem(code: '3', name: 'three', textIcon: Icons.article),
          DropdownItem(code: '4', name: 'four', textIcon: Icons.article),
          DropdownItem(code: '5', name: 'five', textIcon: Icons.article),
        ],
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/nested/default',
      builder: (context) => MultiSelectDropDown<int>(
        isSearchable: context.knobs.boolean(label: 'Searchable', initial: false),
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
          DropdownItem(
              code: '1',
              name: 'one',
              type: 'Group A'),
          DropdownItem(
              code: '2',
              name: 'two',
              type: 'Group B'),
          DropdownItem(
              code: '3',
              name: 'three',
              type: 'Group B'),
          DropdownItem(
              code: '4',
              name: 'four',
              type: 'Group B'),
          DropdownItem(
              code: '5',
              name: 'five',
              type: 'Group A'),
        ],
        selectionType: SelectionType.nestedSelect,
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/nested/nested text',
      builder: (context) => MultiSelectDropDown<int>(
        isSearchable: context.knobs.boolean(label: 'Searchable', initial: false),
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
          DropdownItem(
              code: '1',
              name: 'one',
              description: 'description for one',
              type: 'Group A'),
          DropdownItem(
              code: '2',
              name: 'two',
              description: 'description for two',
              type: 'Group B'),
          DropdownItem(
              code: '3',
              name: 'three',
              description: 'description for third',
              type: 'Group B'),
          DropdownItem(
              code: '4',
              name: 'four',
              description: 'description for four',
              type: 'Group B'),
          DropdownItem(
              code: '5',
              name: 'five',
              description: 'description for five',
              type: 'Group A'),
        ],
        selectionType: SelectionType.nestedSelect,
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/nested/icon',
      builder: (context) => MultiSelectDropDown<int>(
        isSearchable: context.knobs.boolean(label: 'Searchable', initial: false),
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<DropdownItem> selectedOptions) {},
        options: const [
          DropdownItem(
            code: '1',
            name: 'one',
            type: 'Group A',
            textIcon: Icons.article,
          ),
          DropdownItem(
            code: '2',
            name: 'two',
            type: 'Group B',
            textIcon: Icons.article,
          ),
          DropdownItem(
            code: '3',
            name: 'three',
            type: 'Group B',
            textIcon: Icons.article,
          ),
          DropdownItem(
            code: '4',
            name: 'four',
            type: 'Group B',
            textIcon: Icons.article,
          ),
          DropdownItem(
            code: '5',
            name: 'five',
            type: 'Group A',
            textIcon: Icons.article,),
        ],
        selectionType: SelectionType.nestedSelect,
      ),
    ),
    Story(
      name: 'Atom/Dropdown/MultiSelect Dropdown/tree',
      builder: (context) => TreeSelectDropDown<int>(
        isDisabled: context.knobs
            .boolean(label: 'disabled', initial: false),
        onOptionSelected: (List<TreeNode> selectedOptions) {},
        options: [
          TreeNode('A', 'A', [
            TreeNode('A.A1', 'A1', []),
            TreeNode('A.A2', 'A2', []),
          ]),
          TreeNode('B', 'B', [
            TreeNode('B.B1', 'B1', []),
            TreeNode('B.B2', 'B2', []),
          ]),
          TreeNode('C', 'C', [
            TreeNode('C.C1', 'C1', []),
            TreeNode('C.C2', 'C2', []),
          ]),
          TreeNode('D', 'D', [
            TreeNode('D.D1', 'D1', []),
            TreeNode('D.D2', 'D2', []),
          ]),
        ],
        treeSelectionType: DropdownType.multiSelect,
      ),
    ),
  ];
}