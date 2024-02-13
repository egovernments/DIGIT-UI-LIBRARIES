/*
/// `DigitTextAreaFormInput` is a customizable formfield widget that extends the baseforminput.

 Example usage:
 ```dart
 DigitTextAreaFormInput(
 controller: _textController,
 label: 'Description',
 innerLabel: 'Enter your details',
 charCount: true,
 helpText: 'This is a simple example of DigitTextAreaFormInput',
 onChange: (value) {
 print(value);
 },
 ),
 ....*/

import 'package:digit_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitTextAreaFormInput extends BaseDigitFormInput {
  const DigitTextAreaFormInput({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? initialValue,
    String? infoText,
    TextAreaScroll textAreaScroll = TextAreaScroll.auto,
    bool? info,
    bool readOnly = false,
    bool isDisabled = false,
    bool isRequired = false,
    bool charCount = false,
    String? innerLabel,
    String? helpText,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    void Function(String?)? onError,
    final List<Validator>? validations,
    int maxLine = 10,
    double height = 200,
    final void Function(String)? onChange,
  }) : super(
    key: key,
    controller: controller,
    label: label,
    info: info,
    infoText: infoText,
    readOnly: readOnly,
    isRequired: isRequired,
    isDisabled: isDisabled,
    charCount: charCount,
    innerLabel: innerLabel,
    helpText: helpText,
    triggerMode: triggerMode,
    preferToolTipBelow: preferToolTipBelow,
    onError: onError,
    maxLine: maxLine,
    initialValue: initialValue,
    height: height,
    validations: validations,
    onChange: onChange,
    textAreaScroll: textAreaScroll,
    isTextArea: true,
  );

  @override
  _DigitTextAreaFormInputState createState() => _DigitTextAreaFormInputState();
}

class _DigitTextAreaFormInputState extends BaseDigitFormInputState {
  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here

    return super.build(context);
  }
}

// import 'package:flutter/material.dart';
// class DigitTextAreaFormInput extends StatefulWidget {
//   @override
//   _DigitTextAreaFormInputState createState() => _DigitTextAreaFormInputState();
// }
//
// class _DigitTextAreaFormInputState extends State<DigitTextAreaFormInput> {
//   final TextEditingController _textEditingController = TextEditingController();
//   double _width = 380.0;
//   double _height = 100.0;
//
// //   @override
// Widget build(BuildContext context) {
//   return Row(
//       children: [
//         Stack(
//           children: [
//             StatefulBuilder(
//                 builder: (context, setState) {
//                   return Container(
//                     width: _width,
//                     height: _height,
//                     constraints: const BoxConstraints(
//                       minWidth: 156,
//                       minHeight: 40,
//                     ),
//                     child: TextFormField(
//                       controller: _textEditingController,
//                       maxLines: 1000,
//                       onChanged: (text) {
//                         // Check if the text is fitting inside the container
//                         final textPainter = TextPainter(
//                           text: TextSpan(text: text),
//                           maxLines: 100,
//                           textDirection: TextDirection.ltr,
//                         )
//                           ..layout(maxWidth: _width - 20.0); // 20.0 for padding
//                         if (textPainter.height > _height - 60) {
//                           setState(() {
//                             // If the text overflows, increase the height of the container
//                             _height = _height + 20.0;
//                           });
//                         }
//                       },
//                     ),
//                   );
//                 }
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: MouseRegion(
//                 cursor: SystemMouseCursors.resizeUpLeftDownRight,
//                 child: GestureDetector(
//                   onPanUpdate: (details) {
//                     if (details.delta.dx > 0) {
//                       setState(() {
//                         _width = _width + details.delta.dx;
//                       });
//                     } else {
//                       setState(() {
//                         _width = _width + details.delta.dx;
//                       });
//                     }
//
//                     if (details.delta.dy > 0) {
//                       setState(() {
//                         _height = _height + details.delta.dy;
//                       });
//                     } else {
//                       setState(() {
//                         _height = _height + details.delta.dy;
//                       });
//                     }
//                     print(_height);
//                     print(_width);
//                   },
//                   child: Transform.rotate(
//                     angle: -0.5, // Adjust the angle as needed
//                     child: Icon(Icons.drag_handle, size: 16,),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ]
//
//   );
// }}