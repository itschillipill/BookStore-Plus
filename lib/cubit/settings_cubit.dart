// cubit/settings_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final ThemeMode themeMode;

  SettingsState({required this.themeMode});

  factory SettingsState.initial() {
    return SettingsState(themeMode: ThemeMode.system);
  }

  SettingsState copyWith({ThemeMode? themeMode}) {
    return SettingsState(themeMode: themeMode ?? this.themeMode);
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

 void toggleTheme(ThemeMode? themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

}