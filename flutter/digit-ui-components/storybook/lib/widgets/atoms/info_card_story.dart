import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> infoCardStories() {
  return [
    Story(
      name: 'Info/Info',
      builder: (context) => const InfoCard(
        title: 'Info',
        type: InfoType.info,
        description:
        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
      ),
    ),
    Story(
      name: 'Info/Success',
      builder: (context) => const InfoCard(
        title: 'Success',
        type: InfoType.success,
        description:
        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
      ),
    ),
    Story(
      name: 'Info/Error',
      builder: (context) => const InfoCard(
        title: 'Error',
        type: InfoType.error,
        description:
        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
      ),
    ),
    Story(
      name: 'Info/Warning',
      builder: (context) => const InfoCard(
        title: 'Warning',
        type: InfoType.warning,
        description:
        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
      ),
    ),
  ];
}
