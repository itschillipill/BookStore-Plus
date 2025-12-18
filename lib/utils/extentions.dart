import 'package:book_store_plus/dependencies/dependencies.dart';
import 'package:book_store_plus/dependencies/widgets/dependencies_scope.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Dependencies get deps => DependenciesScope.of(this);
}
