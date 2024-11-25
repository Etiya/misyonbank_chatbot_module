import 'package:dartz/dartz.dart';
import 'package:inapp_popup_sdk/features/showpopup/data/models/custom_info.dart';

abstract interface class ServiceRepository {
  Future<Either<String, CustomInfo>> getInfo();
}
