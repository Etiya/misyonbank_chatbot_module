import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_domain/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdRepositoryImpl extends DeviceIdRepository {
  static const deviceIDKey = 'chatbot_deviceId';

  String generateDeviceId() {
    final uuid = const Uuid().v1();
    return uuid;
  }

  @override
  Future<String> fetchDeviceId() async {
    const preferenceKey = deviceIDKey;
    final sp = await SharedPreferences.getInstance();
    final deviceId = sp.getString(preferenceKey);
    if (deviceId == null) {
      final generatedDeviceID = generateDeviceId();
      sp.setString(preferenceKey, generatedDeviceID);
      return generatedDeviceID;
    }
    return deviceId;
  }
}
