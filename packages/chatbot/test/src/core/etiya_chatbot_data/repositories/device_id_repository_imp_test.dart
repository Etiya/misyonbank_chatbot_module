import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DeviceIdRepositoryImpl Tests', () {
    late DeviceIdRepositoryImpl deviceIdRepository;

    setUp(() {
      deviceIdRepository = DeviceIdRepositoryImpl();
    });

    test('fetchDeviceId returns existing deviceId when already stored',
        () async {
      const storedDeviceId = 'existing-device-id';

      // Arrange: Initialize mock SharedPreferences values
      SharedPreferences.setMockInitialValues({
        DeviceIdRepositoryImpl.deviceIDKey: storedDeviceId,
      });

      // Act: Call fetchDeviceId
      final result = await deviceIdRepository.fetchDeviceId();

      // Assert: Verify the correct value is returned
      expect(result, storedDeviceId);
    });

    test('fetchDeviceId generates and stores new deviceId when none exists',
        () async {
      // Arrange: Initialize empty mock SharedPreferences values
      SharedPreferences.setMockInitialValues({});

      // Act: Call fetchDeviceId
      final result = await deviceIdRepository.fetchDeviceId();

      // Assert: Verify a new device ID is generated and stored
      expect(result, isNotEmpty);

      // Verify the value is stored in SharedPreferences
      final sp = await SharedPreferences.getInstance();
      final storedDeviceId = sp.getString(DeviceIdRepositoryImpl.deviceIDKey);
      expect(storedDeviceId, result);
    });

    test('generateDeviceId generates a valid UUID', () {
      // Act: Generate a device ID
      final uuid = deviceIdRepository.generateDeviceId();

      // Assert: Check if the UUID is valid
      expect(uuid, isNotEmpty);
      expect(Uuid.isValidUUID(fromString: uuid), true);
    });
  });
}
