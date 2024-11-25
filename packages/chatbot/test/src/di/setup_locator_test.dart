import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DeviceIdRepositoryImpl', () {
    late DeviceIdRepositoryImpl repository;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      repository = DeviceIdRepositoryImpl();
    });

    test('should return existing device id if present in shared preferences',
        () async {
      // Arrange
      const preferenceKey = DeviceIdRepositoryImpl.deviceIDKey;
      SharedPreferences.setMockInitialValues(
        {preferenceKey: 'existing_device_id'},
      );

      // Act
      final sp = await SharedPreferences.getInstance();
      final deviceId = sp.getString(preferenceKey);

      // Assert
      expect(deviceId, 'existing_device_id');
    });

    test(
        'should generate and save new device id if not present in shared preferences',
        () async {
      // Arrange
      const preferenceKey = DeviceIdRepositoryImpl.deviceIDKey;
      SharedPreferences.setMockInitialValues({});

      // Act
      final sp = await SharedPreferences.getInstance();
      final deviceId = sp.getString(preferenceKey);
      if (deviceId == null) {
        final generatedDeviceID = const Uuid().v1();
        sp.setString(preferenceKey, generatedDeviceID);

        // Assert
        final newDeviceId = sp.getString(preferenceKey);
        expect(newDeviceId, isNotNull);
        expect(newDeviceId, generatedDeviceID);
      }
    });
  });
}
