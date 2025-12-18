// main.dart
import 'dart:async';

import 'package:book_store_plus/dependencies/initialization.dart';
import 'package:book_store_plus/dependencies/widgets/initialization_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'dependencies/widgets/dependencies_scope.dart';
import 'dependencies/widgets/splash_screen.dart';

void main() => runZonedGuarded(() {
  final initialization = InitializationExecutor();
  runApp(
    DependenciesScope(
      initialization: initialization(
        orientations: [DeviceOrientation.portraitUp],
        onError: $initializationErrorHandler,
      ),
      splashScreen: InitializationSplashScreen(progress: initialization),
      child: const App(),
    ),
  );
}, (error, stack) {});
