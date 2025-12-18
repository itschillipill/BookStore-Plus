import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:book_store_plus/pages/home_page.dart';

void main() {
  testWidgets('App smoke test: HomePage renders search field',
      (WidgetTester tester) async {
    // 1. Запускаем минимальное окружение
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // 2. Проверяем, что есть поле поиска
    expect(find.byType(TextField), findsOneWidget);

    // 3. Проверяем текст-подсказку
    expect(find.text('Нажмите для поиска'), findsOneWidget);
  });
}
