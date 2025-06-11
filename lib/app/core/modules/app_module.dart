import 'app_module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

abstract class AppModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  AppModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  }) : _routers = routers,
       _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => AppModulePage(bindings: _bindings, page: pageBuilder),
      ),
    );
  }
}
