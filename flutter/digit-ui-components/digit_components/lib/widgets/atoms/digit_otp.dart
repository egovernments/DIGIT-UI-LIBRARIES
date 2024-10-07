import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/spacers.dart';

class DigitOTPInput extends StatefulWidget {
  /// TextField Controller
  final OtpFieldControllerV2? controller;

  /// Number of the OTP Fields
  final int length;

  /// Total Width of the OTP Text Field
  final double width;

  /// Width of the single OTP Field
  final double fieldWidth;

  /// space between the text fields
  final double spaceBetween;

  /// content padding of the text fields
  final EdgeInsets contentPadding;

  /// Manage the type of keyboard that shows up
  final TextInputType keyboardType;

  /// show the error border or not
  final bool hasError;

  final TextCapitalization textCapitalization;


  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Whether the [InputDecorator.child] is part of a dense form (i.e., uses less vertical
  /// space).
  final bool isDense;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String>? onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String>? onCompleted;

  /// Change cursor color
  final Color? cursorColor;

  /// Change auto Focus on first field
  final bool autoFocus;

  final String? errorMessage;

  final String? label;

  /// Input Formatter
  final List<TextInputFormatter>? inputFormatter;

  const DigitOTPInput({
    Key? key,
    this.length = 4,
    this.width = 10,
    this.controller,
    this.fieldWidth = 30,
    this.spaceBetween = 0,
    this.hasError = false,
    this.keyboardType = TextInputType.number,
    this.label,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.onChanged,
    this.errorMessage,
    this.inputFormatter,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    this.isDense = false,
    this.onCompleted,
    this.cursorColor,
    this.autoFocus = false,
  }) : assert(length > 1), super(key: key);

  @override
  DigitOTPInputState createState() => DigitOTPInputState();
}

class DigitOTPInputState extends State<DigitOTPInput> {
  late List<FocusNode?> _focusNodes;
  bool _hasError = false;
  late List<TextEditingController?> _textControllers;
  late List<String> _pin;
  int _focusedIndex = 0; // Track the currently focused index
  late List<FocusNode> _keyboardFocusNodes;

  @override
  void initState() {
    super.initState();

    if (widget.hasError) {
      _hasError = true;
    }

    if (widget.controller != null) {
      widget.controller!.setOtpTextFieldState(this);
    }
    _keyboardFocusNodes = List.generate(widget.length, (_) => FocusNode());
    _focusNodes = List<FocusNode?>.filled(widget.length, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.length, null, growable: false);
    _pin = List.generate(widget.length, (int i) => '');
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
         focusNode?.removeListener(() => handleFocusChange);
         focusNode?.dispose();
     }

    for (var focusNode in _keyboardFocusNodes) {
      focusNode.dispose();
    }

    for (var controller in _textControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(widget.label != null)
            ...[
            Text(
              widget.label!,
              style: textTheme.bodyL.copyWith(
                color: theme.colorTheme.text.primary,
              ),
              textAlign: TextAlign.center,
            ),
              const SizedBox(height: 16,),
            ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return _buildTextField(context, index);
            }),
          ),
          if(widget.errorMessage != null && _hasError)
            ...[
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: spacer1 / 2,
                      ),
                      SizedBox(
                        height: spacer4,
                        width: spacer4,
                        child: Icon(
                          Icons.info,
                          color: theme.colorTheme.alert.error,
                          size: spacer4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: spacer1),
                  Text(
                    widget.errorMessage!,
                    style: textTheme.bodyL.copyWith(
                      color: theme.colorTheme.alert.error,
                    ),
                  ),
                ],
              ),
            ]
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, int index) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    FocusNode? focusNode = _focusNodes[index];
    TextEditingController? textEditingController = _textControllers[index];

    if (focusNode == null) {
      _focusNodes[index] = FocusNode();
      focusNode = _focusNodes[index];
      focusNode?.addListener(() => handleFocusChange(index));
    }
    if (textEditingController == null) {
      _textControllers[index] = TextEditingController();
      textEditingController = _textControllers[index];
    }

    final isLast = index == widget.length - 1;

    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.only(
        right: isLast ? 0 : 8,
      ),
      child: RawKeyboardListener(
        focusNode: _keyboardFocusNodes[index],
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _moveFocus(-1);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              _moveFocus(1);
            } else if (event.logicalKey == LogicalKeyboardKey.backspace ||
                event.logicalKey == LogicalKeyboardKey.delete ) {
              if (_focusedIndex > 0) {

                // Check if the currently focused TextField is empty
                if (_textControllers[_focusedIndex]!.text.isEmpty) {
                  _focusNodes[_focusedIndex - 1]?.requestFocus();
                }
              }
            }
          }
        },
        child: TextField(
          controller: _textControllers[index],
          maxLength: _textControllers[index]!= null && _textControllers[index]!.text.isEmpty ? null : 1,
          keyboardType: widget.keyboardType,
          cursorColor: widget.cursorColor,
          textCapitalization: widget.textCapitalization,
          textAlign: TextAlign.center,
          style: textTheme.headingM.copyWith(color: theme.colorTheme.text.primary),
          inputFormatters: widget.inputFormatter,
          autofocus: index == 0 && widget.autoFocus,
          focusNode: _focusNodes[index],
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            isDense: widget.isDense,
            counterText: "",
            constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
            contentPadding: widget.contentPadding,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: _hasError
                    ? theme.colorTheme.alert.error
                    : theme.colorTheme.generic.inputBorder,
                width: _hasError ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: theme.colorTheme.primary.primary1,
                width: 1.5,
              ),
            ),
          ),
          onChanged: (String str) {
            setState(() {
              _hasError = false;
            });

            if (str.length > 1) {
              _handlePaste(str, _findFirstEmptyIndex());
              return;
            }

            // Check if the current index is empty (cleared)
            if (str.isEmpty && _pin[index].isNotEmpty) {
              // Shift all digits after the current index to the left
              for (int i = index; i < widget.length - 1; i++) {
                _pin[i] = _pin[i + 1]; // Shift the next digit to the current position
                _textControllers[i]?.text = _pin[i]; // Update the text controller
              }

              // Clear the last field
              _pin[widget.length - 1] = '';
              _textControllers[widget.length - 1]?.clear();

              // Move the focus to the current position or previous if needed
              if (index > 0) {
                _focusNodes[index]?.unfocus();
                _focusNodes[index - 1]?.requestFocus();
                _textControllers[index - 1]?.selection = const TextSelection.collapsed(offset: 0);
              }
            } else {
              int idx = _findFirstEmptyIndex();

              if (idx == widget.length) {
                return; // All fields are filled
              }
                setState(() {
                  _textControllers[index]!.text = '';
                  _textControllers[idx]!.text = str;
                  _pin[idx] = str;
                });

              if (str.isEmpty) {
                if (index > 0) {
                  _focusNodes[index]!.unfocus();
                  _focusNodes[index - 1]!.requestFocus();
                }
              } else if (idx + 1 < widget.length) {
                FocusScope.of(context).requestFocus(_focusNodes[idx + 1]);
              }
            }

            // Recalculate the current pin
            String currentPin = _getCurrentPin();

            // Call the appropriate callbacks
            if (!_pin.contains('') && currentPin.length == widget.length) {
              widget.onCompleted?.call(currentPin);
            }

            widget.onChanged?.call(currentPin);
          },

        ),
      ),
    );
  }

  int _findFirstEmptyIndex() {
    for (int i = 0; i < _pin.length; i++) {
      if (_pin[i].isEmpty) {
        return i;
      }
    }
    return _pin.length; // Return length if all fields are filled
  }


  @override
  void didUpdateWidget(covariant DigitOTPInput oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void handleFocusChange(int index) {
    FocusNode? focusNode = _focusNodes[index];
    TextEditingController? controller = _textControllers[index];

    if (focusNode == null || controller == null) return;

    if (focusNode.hasFocus) {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      _focusedIndex = index; // Update focused index
    }
  }

  String _getCurrentPin() {
    String currentPin = "";
    for (var value in _pin) {
      currentPin += value;
    }
    return currentPin;
  }

  void _handlePaste(String str, int index) {
    // Ensure the pasted string doesn't exceed the maximum length
    if (str.length > widget.length) {
      str = str.substring(0, widget.length);
    }

    // Start replacing from the specified index
    for (int i = index; i < widget.length; i++) {
      if (i < index + str.length) {
        // If within the range of the pasted string, replace the current value
        String digit = str[i - index];
        _textControllers[i]!.text = digit;
        _pin[i] = digit;
      } else {
        // If past the pasted string length, clear the remaining fields
        _textControllers[i]!.text = '';
        _pin[i] = '';
      }
    }

    // Move focus to the next empty field or unfocus if all are filled
    int nextIndex = index + str.length < widget.length ? index + str.length-1 : widget.length - 1;
    if (nextIndex < widget.length && _pin[nextIndex] != '') {
      // Move focus to the next empty field
      for (int i = nextIndex; i < widget.length; i++) {
        if (_pin[i] == '') {
          FocusScope.of(context).requestFocus(_focusNodes[i]);
          return;
        }
      }
      // If no empty fields left, focus last one
      FocusScope.of(context).requestFocus(_focusNodes[widget.length-1]);
    } else {
      FocusScope.of(context).requestFocus(_focusNodes[widget.length-1]);
    }

    // Get the current PIN
    String currentPin = _getCurrentPin();

    // Trigger completion callback if the PIN is fully filled
    if (!_pin.contains('') && currentPin.length == widget.length) {
      widget.onCompleted?.call(currentPin);
    }

    // Trigger change callback
    widget.onChanged?.call(currentPin);
  }



  void _moveFocus(int direction) {
    int newIndex = _focusedIndex + direction;

    if (newIndex < 0) {
      newIndex = widget.length - 1;
    } else if (newIndex >= widget.length) {
      newIndex = 0;
    }

    if (_focusedIndex != newIndex) {
      FocusScope.of(context).requestFocus(_focusNodes[newIndex]);
      _focusedIndex = newIndex;
    }
  }
}

class OtpFieldControllerV2 {
  late DigitOTPInputState _otpTextFieldState;

  void setOtpTextFieldState(DigitOTPInputState state) {
    _otpTextFieldState = state;
  }

  void clear() {
    final textFieldLength = _otpTextFieldState.widget.length;
    _otpTextFieldState._pin = List.generate(textFieldLength, (int i) => '');

    final textControllers = _otpTextFieldState._textControllers;
    for (var textController in textControllers) {
      if (textController != null) {
        textController.text = '';
      }
    }

    final firstFocusNode = _otpTextFieldState._focusNodes[0];
    if (firstFocusNode != null) {
      FocusScope.of(_otpTextFieldState.context).requestFocus(firstFocusNode);
    }
  }

  String getOtpText() {
    return _otpTextFieldState._getCurrentPin();
  }

  void setOtpText(String text) {
    if (text.length > _otpTextFieldState.widget.length) {
      text = text.substring(0, _otpTextFieldState.widget.length);
    }

    _otpTextFieldState._pin = List.generate(_otpTextFieldState.widget.length, (index) {
      return index < text.length ? text[index] : '';
    });

    for (int i = 0; i < _otpTextFieldState._textControllers.length; i++) {
      _otpTextFieldState._textControllers[i]?.text = _otpTextFieldState._pin[i];
    }

    final lastIndex = text.length - 1;
    if (lastIndex >= 0 && lastIndex < _otpTextFieldState.widget.length) {
      FocusScope.of(_otpTextFieldState.context)
          .requestFocus(_otpTextFieldState._focusNodes[lastIndex]);
    }
  }
}
