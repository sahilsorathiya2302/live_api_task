import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:milk_ride_live_wc/core/common_model/api_response_model.dart';
import 'package:milk_ride_live_wc/core/constants/app_string.dart';
import 'package:milk_ride_live_wc/core/utils/functional_component.dart';
import 'package:milk_ride_live_wc/features/subscription/domain/usecase/subscription_use_case.dart';
import 'package:milk_ride_live_wc/features/subscription/presentation/cubit/subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionUseCase subscriptionUseCase;

  SubscriptionCubit(this.subscriptionUseCase)
      : super(const SubscriptionInitial());

  Future<void> addToCart({
    required int packageId,
    required int customerId,
    required int userId,
    required String frequencyType,
    required String? frequencyValue,
    required int qty,
    required String? schedule,
    required int dayWiseQuantity,
    required String deliveryType,
    required String? startDate,
    required String? endDate,
    required int trialProduct,
    required int noOfUsages,
    required int productId,
  }) async {
    Get.context?.loaderOverlay.show();
    final result = await subscriptionUseCase.call(SubscriptionParam(
      packageId: packageId,
      customerId: customerId,
      userId: userId,
      frequencyType: frequencyType,
      frequencyValue: frequencyValue ?? AppString.empty,
      qty: qty,
      schedule: schedule ?? AppString.empty,
      deliveryType: deliveryType,
      startDate: startDate ?? AppString.empty,
      endDate: endDate ?? AppString.empty,
      trialProduct: trialProduct,
      noOfUsages: noOfUsages,
      productId: productId,
      dayWiseQuantity: [],
    ));

    result.fold(
      (failure) {
        FunctionalComponent.errorSnackbar(message: failure.message);
      },
      (result) {
        if (result.status == AppString.success) {
          FunctionalComponent.successMessageSnackbar(message: result.message);
        } else if (result.status == AppString.error) {
          FunctionalComponent.errorSnackbar(message: result.message);
        }
      },
    );
    Get.context?.loaderOverlay.hide();
  }

  Future<void> subscriptionCreate({
    required int packageId,
    required int customerId,
    required int userId,
    required String frequencyType,
    required String frequencyValue,
    required int qty,
    required String schedule,
    required List<int> dayWiseQuantity,
    required String deliveryType,
    required String startDate,
    required String endDate,
    required int trialProduct,
    required int noOfUsages,
    required int productId,
  }) async {
    Get.context?.loaderOverlay.show();
    final result = await subscriptionUseCase.call(SubscriptionParam(
      packageId: packageId,
      customerId: customerId,
      userId: userId,
      frequencyType: frequencyType,
      frequencyValue: frequencyValue,
      qty: qty,
      schedule: schedule,
      dayWiseQuantity: dayWiseQuantity,
      deliveryType: deliveryType,
      startDate: startDate,
      endDate: endDate,
      trialProduct: trialProduct,
      noOfUsages: noOfUsages,
      productId: productId,
    ));

    result.fold(
      (failure) {
        FunctionalComponent.errorSnackbar(message: failure.message);
      },
      (result) {
        if (result.status == AppString.success) {
          FunctionalComponent.successMessageSnackbar(message: result.message);
        } else if (result.status == AppString.error) {
          FunctionalComponent.errorSnackbar(message: result.message);
        }
      },
    );
    Get.context?.loaderOverlay.hide();
  }

  void setLoading() {
    emit(SubscriptionLoading(
      endDate: state.endDate,
      startDate: state.startDate,
      quantity: state.quantity,
      deliveryType: state.deliveryType,
      deliverySchedule: state.deliverySchedule,
      dayQuantities: state.dayQuantities,
      frequencyType: state.frequencyType,
      frequencyValue: state.frequencyValue,
      dayWiseQuantity: state.dayWiseQuantity,
    ));
  }

  void setLoaded(ApiResponseModel apiResponseModel) {
    emit(SubscriptionLoaded(
      endDate: state.endDate,
      startDate: state.startDate,
      apiResponseModel: apiResponseModel,
      quantity: state.quantity,
      deliveryType: state.deliveryType,
      deliverySchedule: state.deliverySchedule,
      dayQuantities: state.dayQuantities,
      frequencyType: state.frequencyType,
      frequencyValue: state.frequencyValue,
      dayWiseQuantity: state.dayWiseQuantity,
    ));
  }

  void incrementQuantity() {
    _emitUpdatedQuantity(state.quantity + 1);
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      _emitUpdatedQuantity(state.quantity - 1);
    }
  }

  void setQuantity(int quantity) {
    _emitUpdatedQuantity(quantity);
  }

  void _emitUpdatedQuantity(int newQty) {
    if (state is SubscriptionLoaded) {
      emit((state as SubscriptionLoaded).copyWith(quantity: newQty));
    } else {
      emit(SubscriptionLoading(
        endDate: state.endDate,
        startDate: state.startDate,
        quantity: newQty,
        deliveryType: state.deliveryType,
        deliverySchedule: state.deliverySchedule,
        dayQuantities: state.dayQuantities,
        frequencyType: state.frequencyType,
        frequencyValue: state.frequencyValue,
        dayWiseQuantity: state.dayWiseQuantity,
      ));
    }
  }

  void setStartDate(String startDate) {
    print("1===========>$startDate");

    if (state is SubscriptionLoaded) {
      emit((state as SubscriptionLoaded).copyWith(startDate: startDate));
    } else {
      emit(SubscriptionLoading(
        quantity: state.quantity,
        deliveryType: state.deliveryType,
        deliverySchedule: state.deliverySchedule,
        dayQuantities: state.dayQuantities,
        frequencyType: state.frequencyType,
        frequencyValue: state.frequencyValue,
        dayWiseQuantity: state.dayWiseQuantity,
        startDate: startDate,
        endDate: state.endDate,
      ));
    }

    setCurrent();
  }

  void setEndDate(String endDate) {
    if (state is SubscriptionLoaded) {
      setCurrent();
      emit((state as SubscriptionLoaded).copyWith(endDate: endDate));
    } else {
      emit(SubscriptionLoading(
        quantity: state.quantity,
        deliveryType: state.deliveryType,
        deliverySchedule: state.deliverySchedule,
        dayQuantities: state.dayQuantities,
        frequencyType: state.frequencyType,
        frequencyValue: state.frequencyValue,
        dayWiseQuantity: state.dayWiseQuantity,
        startDate: state.startDate,
        endDate: endDate,
      ));
    }
  }

  void changeDeliveryType(String newType) {
    if (state is SubscriptionLoaded) {
      emit((state as SubscriptionLoaded).copyWith(deliveryType: newType));
    } else {
      emit(SubscriptionLoading(
        endDate: state.endDate,
        startDate: state.startDate,
        quantity: state.quantity,
        deliveryType: newType,
        deliverySchedule: state.deliverySchedule,
        dayQuantities: state.dayQuantities,
        frequencyType: state.frequencyType,
        frequencyValue: state.frequencyValue,
        dayWiseQuantity: state.dayWiseQuantity,
      ));
    }
  }

  void changeDeliverySchedule(String schedule) {
    String frequencyType = '';
    dynamic frequencyValue;
    List<int> dayWiseQuantity = [];

    switch (schedule) {
      case "Every Day":
        frequencyType = "every_day";
        frequencyValue = 1;
        break;
      case "Alternate Day":
        frequencyType = "alternate_day";
        frequencyValue = 2;
        break;
      case "Every 3 Day":
        frequencyType = "every_3_day";
        frequencyValue = 3;
        break;
      case "Day Wise":
        frequencyType = "day_wise";
        frequencyValue = [1, 0, 1, 0, 0, 0, 1];
        dayWiseQuantity = [1, 0, 1, 0, 0, 0, 1];
        break;
    }

    if (state is SubscriptionLoaded) {
      emit((state as SubscriptionLoaded).copyWith(
        deliverySchedule: schedule,
        frequencyType: frequencyType,
        frequencyValue: frequencyValue,
        dayWiseQuantity: dayWiseQuantity,
      ));
    } else {
      emit(SubscriptionLoading(
        endDate: state.endDate,
        startDate: state.startDate,
        quantity: state.quantity,
        deliveryType: state.deliveryType,
        deliverySchedule: schedule,
        dayQuantities: state.dayQuantities,
        frequencyType: frequencyType,
        frequencyValue: frequencyValue,
        dayWiseQuantity: dayWiseQuantity,
      ));
    }
  }

  void updateDayQuantity(int index, int quantity) {
    final updatedQuantities = List<int>.from(state.dayQuantities);
    updatedQuantities[index] = quantity;

    if (state is SubscriptionLoaded) {
      emit((state as SubscriptionLoaded)
          .copyWith(dayQuantities: updatedQuantities));
    } else {
      emit(SubscriptionLoading(
        endDate: state.endDate,
        startDate: state.startDate,
        quantity: state.quantity,
        deliveryType: state.deliveryType,
        deliverySchedule: state.deliverySchedule,
        dayQuantities: updatedQuantities,
        frequencyType: state.frequencyType,
        frequencyValue: state.frequencyValue,
        dayWiseQuantity: state.dayWiseQuantity,
      ));
    }
  }

  void setCurrent() {
    if (state is SubscriptionLoaded) {
      final currentState = state as SubscriptionLoaded;
      emit(currentState.copyWith(
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        // other properties...
      ));
    } else if (state is SubscriptionLoading) {
      // Handle SubscriptionLoading state
      final currentState = state;
      emit(SubscriptionLoading(
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        quantity: currentState.quantity,
        deliveryType: currentState.deliveryType,
        deliverySchedule: currentState.deliverySchedule,
        dayQuantities: currentState.dayQuantities,
        frequencyType: currentState.frequencyType,
        frequencyValue: currentState.frequencyValue,
        dayWiseQuantity: currentState.dayWiseQuantity,
      ));
    }
  }

  void resetState() {
    emit(const SubscriptionInitial());
  }
}
