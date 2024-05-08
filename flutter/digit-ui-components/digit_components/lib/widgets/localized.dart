import 'package:flutter/material.dart';

import '../blocs/AppLocalization.dart';


abstract class LocalizedStatefulWidget extends StatefulWidget {
  final AppLocalization? appLocalizations;

  const LocalizedStatefulWidget({
    super.key,
    this.appLocalizations,
  });
}

abstract class LocalizedState<T extends LocalizedStatefulWidget>
    extends State<T> {
  late AppLocalization _localizations;

  AppLocalization get localizations => _localizations;

  set localizations(AppLocalization localizations) {
    if (mounted) {
      setState(() {
        _localizations = localizations;
      });
    }
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    _localizations = widget.appLocalizations ?? AppLocalization.of(context);
    super.didChangeDependencies();
  }
}
