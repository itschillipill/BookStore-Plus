// app.dart 

import 'package:book_store_plus/cubit/settings_cubit.dart';
import 'package:book_store_plus/utils/constants/constants.dart';
import 'package:book_store_plus/services/message_service.dart';
import 'package:book_store_plus/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';
import 'utils/theme/theme.dart';
import 'widgets/windows_scope.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => context.deps.booksCubit),
        BlocProvider(create: (_) => context.deps.settingsCubit),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            scaffoldMessengerKey: MessageService.messengerKey,
            navigatorKey: MessageService.navigatorKey,
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: HomePage(),
            builder:
                (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: WindowScope(
                    title: Constants.appName,
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
          );
        },
      ),
    );
  }
}
