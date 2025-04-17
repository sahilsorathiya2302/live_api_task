import 'package:fpdart/fpdart.dart';
import 'package:milk_ride_live_wc/core/common_model/api_response_model.dart';
import 'package:milk_ride_live_wc/core/failures/failure.dart';
import 'package:milk_ride_live_wc/features/subscription/domain/usecase/subscription_use_case.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, ApiResponseModel>> subscriptionCreate(
      {required SubscriptionParam param});
}
