import 'package:digit_ui_components/widgets/atoms/digit_otp.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> otpInputStories() {
  return [
    Story(
      name: 'Atom/OTP Input/Default',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 6,
          autoFocus: true,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/With length 4',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 4,
          autoFocus: true,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/With auto focus off',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 4,
          autoFocus: false,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/Error State',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 5,
          hasError: true,
          autoFocus: true,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/Error State and Error Message',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 5,
          hasError: true,
          errorMessage: 'Invalid otp',
          autoFocus: true,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/With obscure Text',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 5,
          hasError: true,
          autoFocus: true,
          obscureText: true,
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
    Story(
      name: 'Atom/OTP Input/With label',
      builder: (context) => DigitOTPInput(
          controller: OtpFieldControllerV2(),
          length: 5,
          autoFocus: true,
          label: 'Enter OTP',
          width: MediaQuery.of(context).size.width,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
          }),
    ),
  ];
}
