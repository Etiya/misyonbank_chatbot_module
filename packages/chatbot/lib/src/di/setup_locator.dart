import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/repositories/repositories.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DependencyInjection {
  const DependencyInjection._();

  static Future<List<RepositoryProvider>> build(
    EtiyaChatbotBuilder builder,
  ) async {
    final deviceIdRepository = DeviceIdRepositoryImpl();
    final deviceId = deviceIdRepository.generateDeviceId();

    final String visitorId = deviceId;
    final socketRepository = SocketRepositoryImpl(
      url: builder.socketUrl,
      namespace: '/chat',
      query: {'visitorId': visitorId},
    );

    final httpClient = HttpClientRepositoryImpl(
      serviceUrl: builder.serviceUrl,
      authUrl: builder.authUrl!,
      userId: deviceId,
    );

    return [
      RepositoryProvider<SocketClientRepository>(
        create: (_) => socketRepository,
      ),
      RepositoryProvider<HttpClientRepository>(
        create: (_) => httpClient,
      ),
      RepositoryProvider<ChatTheme>(
        create: (_) => builder.chatTheme,
      ),
    ];
  }
}
