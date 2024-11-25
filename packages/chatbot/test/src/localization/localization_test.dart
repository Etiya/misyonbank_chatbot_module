import 'package:etiya_chatbot_flutter/src/localization/generated/app_localizations.dart';
import 'package:etiya_chatbot_flutter/src/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Localization extension test', (WidgetTester tester) async {
    // Test için bir MaterialApp oluşturun
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // Desteklenen diller
        ],
        home: TestWidget(),
      ),
    );

    // TestWidget'in bulunduğundan emin olun
    await tester.pumpAndSettle(); // Widget'ın tamamen yüklenmesini bekleyin
    expect(find.byType(TestWidget), findsOneWidget);

    // TestWidget içindeki metnin doğru şekilde lokalize edildiğini kontrol edin
    expect(
      find.text('Submit'),
      findsOneWidget,
    ); // Buradaki "Hello" metnini lokalizasyon dosyanızdaki karşılık gelen değerle değiştirin
  });
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lokalizasyon fonksiyonunu kullanın
    final localText = context.localization
        .submit; // Buradaki "hello" anahtarını lokalizasyon dosyanızdaki anahtarla değiştirin

    return Scaffold(
      body: Center(
        child: Text(localText),
      ),
    );
  }
}
