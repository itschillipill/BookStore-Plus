import '../cubit/books_cubit.dart';
import '../cubit/settings_cubit.dart';

abstract interface class Dependencies {
  late final BooksCubit booksCubit;
  late final SettingsCubit settingsCubit;
}
