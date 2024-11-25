import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:etiya_chatbot_flutter/src/core/mocks/mock_custom_info.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/models/custom_info.dart';
import 'package:inapp_popup_sdk/features/showpopup/domain/service_repository.dart';

class InAppPopupCustomInfo implements ServiceRepository {
  @override
  Future<Either<String, CustomInfo>> getInfo() async {
    final result = CustomInfo.fromMap(json.decode(mockJsonData));
    return Right(result);
  }
}
