import 'dart:convert';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/repositories/http_client_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late HttpClientRepositoryImpl httpClientRepository;

  const serviceUrl = 'https://example.com/service';
  const authUrl = 'https://example.com/auth';
  const userId = 'test-user-id';

  setUp(() {
    mockHttpClient = MockHttpClient();
    httpClientRepository = HttpClientRepositoryImpl(
      serviceUrl: serviceUrl,
      authUrl: authUrl,
      userId: userId,
    );
  });

  group('HttpClientRepositoryImpl Tests', () {
    test('auth returns false for failed authentication', () async {
      // Arrange
      const username = 'testuser';
      const password = 'wrongpassword';

      when(() => mockHttpClient.post(
            Uri.parse(authUrl),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode({"isAuth": false}), 401),
      );

      // Act
      final result = await httpClientRepository.auth(
        username: username,
        password: password,
      );

      // Assert
      expect(result, false);
    });
  });
}
