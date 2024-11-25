import 'package:etiya_chatbot_flutter/src/presentation/widgets/overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Overlay is shown and removed after 2 seconds',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: (context, child) {
              ScreenUtil.init(context);
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return Scaffold(
                        body: Center(
                          child: ElevatedButton(
                            onPressed: () => showOverlay(context),
                            child: const Text('Show Overlay'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );

        expect(find.text('Kopyalandı'), findsNothing);

        await tester.tap(find.text('Show Overlay'));
        await tester.pump();

        expect(find.text('Kopyalandı'), findsOneWidget);

        await tester.pump(const Duration(seconds: 2));

        expect(find.text('Kopyalandı'), findsNothing);
      });
}
