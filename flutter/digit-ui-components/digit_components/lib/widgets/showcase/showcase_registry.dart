import 'package:digit_ui_components/widgets/showcase/showcase_wrapper.dart';

class ShowcaseRegistry {
  static final ShowcaseRegistry _instance = ShowcaseRegistry._internal();
  factory ShowcaseRegistry() => _instance;
  ShowcaseRegistry._internal();

  final List<ShowcaseWrapper> _showcaseItems = [];

  static void register(ShowcaseWrapper item) {
    _instance._showcaseItems.add(item);
  }

  static List<ShowcaseWrapper> get items => _instance._showcaseItems;
}
