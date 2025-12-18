import 'package:book_store_plus/cubit/settings_cubit.dart';
import 'package:book_store_plus/services/message_service.dart';
import 'package:book_store_plus/utils/constants/constants.dart';
import 'package:book_store_plus/utils/extentions.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = User.appUser();

  @override
  Widget build(BuildContext context) {
    final SettingsCubit settingsCubit = context.deps.settingsCubit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            onPressed: _showAboutApp,
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double contentWidth = constraints.maxWidth > 600 ? 500 : constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),

                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      user.phone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),

                    const SizedBox(height: 30),

                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Настройки",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Тема"),
                                DropdownButton<ThemeMode>(
                                  value: settingsCubit.state.themeMode,
                                  items: const [
                                    DropdownMenuItem(value: ThemeMode.system, child: Text("Системная")),
                                    DropdownMenuItem(value: ThemeMode.light, child: Text("Светая")),
                                    DropdownMenuItem(value: ThemeMode.dark, child: Text("Темная")),
                                  ],
                                  onChanged: (value) {
                                    settingsCubit.toggleTheme(value);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {},
                            child: const Text("Редактировать профиль"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Theme.of(context).colorScheme.error),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Выход",
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showAboutApp() async {
  await MessageService.showDialogGlobal(
    (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "О проекте",
          textAlign: TextAlign.center,
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Данный сайт интернет-магазина создан в рамках курсовой работы "
            "в учебных целях и предназначен только для демонстрации. "
            "Проект не является настоящим сервисом и не ведёт реальной торговли.\n\n"
            "Разработано студентом УрГЭУ "
            "группы ПИЭ-22-1. \n"
            "Автор: ${Constants.author}",
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.3),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Ясно"),
          ),
        ],
      );
    },
  );
}
