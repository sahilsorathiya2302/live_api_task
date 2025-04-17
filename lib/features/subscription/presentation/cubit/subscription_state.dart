import 'package:equatable/equatable.dart';
import 'package:milk_ride_live_wc/core/common_model/api_response_model.dart';

abstract class SubscriptionState extends Equatable {
  final int quantity;
  final String deliveryType;
  final String deliverySchedule;
  final List<int> dayQuantities;
  final String startDate;
  final String endDate;
  final String frequencyType;
  final dynamic frequencyValue;
  final List<int> dayWiseQuantity;

  const SubscriptionState({
    required this.quantity,
    required this.deliveryType,
    required this.deliverySchedule,
    required this.dayQuantities,
    required this.startDate,
    required this.endDate,
    required this.frequencyType,
    required this.frequencyValue,
    required this.dayWiseQuantity,
  });

  @override
  List<Object?> get props => [
        quantity,
        startDate,
        endDate,
        deliveryType,
        deliverySchedule,
        dayQuantities,
        frequencyType,
        frequencyValue,
        dayWiseQuantity,
      ];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial()
      : super(
            quantity: 1,
            deliveryType: 'Morning',
            deliverySchedule: '',
            dayQuantities: const [0, 0, 0, 0, 0, 0, 0],
            frequencyType: '',
            frequencyValue: 0,
            dayWiseQuantity: const [0, 0, 0, 0, 0, 0, 0],
            endDate: "",
            startDate: "");
}

class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading({
    required super.quantity,
    required super.deliveryType,
    required super.deliverySchedule,
    required super.dayQuantities,
    required super.frequencyType,
    required super.frequencyValue,
    required super.dayWiseQuantity,
    required super.startDate,
    required super.endDate,
  });

  SubscriptionLoading copyWith({
    int? quantity,
    String? deliveryType,
    String? startDate,
    String? endDate,
    String? deliverySchedule,
    List<int>? dayQuantities,
    String? frequencyType,
    dynamic frequencyValue,
    List<int>? dayWiseQuantity,
  }) {
    return SubscriptionLoading(
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      quantity: quantity ?? this.quantity,
      deliveryType: deliveryType ?? this.deliveryType,
      deliverySchedule: deliverySchedule ?? this.deliverySchedule,
      dayQuantities: dayQuantities ?? this.dayQuantities,
      frequencyType: frequencyType ?? this.frequencyType,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      dayWiseQuantity: dayWiseQuantity ?? this.dayWiseQuantity,
    );
  }
}

class SubscriptionLoaded extends SubscriptionState {
  final ApiResponseModel apiResponseModel;

  const SubscriptionLoaded({
    required this.apiResponseModel,
    required super.quantity,
    required super.startDate,
    required super.endDate,
    required super.deliveryType,
    required super.deliverySchedule,
    required super.dayQuantities,
    required super.frequencyType,
    required super.frequencyValue,
    required super.dayWiseQuantity,
  });

  SubscriptionLoaded copyWith({
    ApiResponseModel? apiResponseModel,
    int? quantity,
    String? deliveryType,
    String? startDate,
    String? endDate,
    String? deliverySchedule,
    List<int>? dayQuantities,
    String? frequencyType,
    dynamic frequencyValue,
    List<int>? dayWiseQuantity,
  }) {
    return SubscriptionLoaded(
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      apiResponseModel: apiResponseModel ?? this.apiResponseModel,
      quantity: quantity ?? this.quantity,
      deliveryType: deliveryType ?? this.deliveryType,
      deliverySchedule: deliverySchedule ?? this.deliverySchedule,
      dayQuantities: dayQuantities ?? this.dayQuantities,
      frequencyType: frequencyType ?? this.frequencyType,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      dayWiseQuantity: dayWiseQuantity ?? this.dayWiseQuantity,
    );
  }

  @override
  List<Object?> get props => [
        apiResponseModel,
        quantity,
        deliveryType,
        startDate,
        endDate,
        deliverySchedule,
        frequencyType,
        frequencyValue,
        dayWiseQuantity
      ];
}

class SubscriptionError extends SubscriptionState {
  const SubscriptionError({
    required super.quantity,
    required super.startDate,
    required super.endDate,
    required super.deliveryType,
    required super.deliverySchedule,
    required super.dayQuantities,
    required super.frequencyType,
    required super.frequencyValue,
    required super.dayWiseQuantity,
  });
  @override
  List<Object?> get props => [
        quantity,
        deliveryType,
        startDate,
        endDate,
        deliverySchedule,
        frequencyType,
        frequencyValue,
        dayWiseQuantity
      ];
}
