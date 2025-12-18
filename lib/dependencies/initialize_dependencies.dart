import 'dart:async';
import 'package:book_store_plus/cubit/books_cubit.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../cubit/settings_cubit.dart';
import 'platform/initialization_vm.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'platform/initialization_js.dart';
import 'package:meta/meta.dart';

import 'dependencies.dart';

typedef _InitializationStep =
    FutureOr<void> Function(MutableDependencies dependencies);

class MutableDependencies implements Dependencies {
  @override
  late BooksCubit booksCubit;
  @override
  late SettingsCubit settingsCubit;
}

mixin InitializeDependencies {
  @protected
  Future<Dependencies> $initializeDependencies({
    void Function(int progress, String message)? onProgress,
  }) async {
    final steps = _initializationSteps;
    final dependencies = MutableDependencies();
    final totalSteps = steps.length;
    for (var currentStep = 0; currentStep < totalSteps; currentStep++) {
      final step = steps[currentStep];
      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.$1);
      debugPrint(
        'Initialization | $currentStep/$totalSteps ($percent%) | "${step.$1}"',
      );
      await step.$2(dependencies);
    }
    return dependencies;
  }

  List<(String, _InitializationStep)> get _initializationSteps =>
      <(String, _InitializationStep)>[
        // 1. Инициализация платформы
        ('Platform pre-initialization', (_) => $platformInitialization()),
        // 2. Инициализация зависимостей
        ("Setting cubit",(deps){
          deps.settingsCubit = SettingsCubit();
        }),
        (
          "Books cubit",
          (deps) async {
            deps.booksCubit = BooksCubit();
          },
        ),
      ];
}
