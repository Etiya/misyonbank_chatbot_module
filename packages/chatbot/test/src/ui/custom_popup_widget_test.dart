import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/ui/custom_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'PopupWidget displays message correctly and handles close button press',
      (WidgetTester tester) async {
    final messageResponse = MessageResponse(
      payload: Payload(
        header: 'Header',
        subHeader: 'SubHeader',
        content: 'This is the content of the message.',
        buttonText: 'Copy',
        annotation: 'Some annotation here.',
        typing: false,
      ),
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Scaffold(
            body: PopupWidget(messageResponse: messageResponse),
          ),
        ),
      ),
    );

    expect(find.text('Header'), findsOneWidget);

    expect(find.text('SubHeader'), findsOneWidget);

    expect(find.text('This is the content of the message.'), findsOneWidget);

    expect(find.text('Copy'), findsOneWidget);

    expect(find.text('Some annotation here.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('Header'), findsNothing);
    expect(find.text('SubHeader'), findsNothing);
    expect(find.text('This is the content of the message.'), findsNothing);
  });
}
