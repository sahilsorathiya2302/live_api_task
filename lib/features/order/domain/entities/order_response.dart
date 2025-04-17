import 'package:milk_ride_live_wc/features/order/domain/entities/order_data.dart';

class OrderResponse {
  final String? status;
  final int? statusCode;
  final String? message;
  final OrderData? data;
  final int? toBeDeliveredGrandTotal;
  final String? toBeDeliveredGrandTotalDecimal;
  final int? deliveredGrandTotal;
  final String? deliveredGrandTotalDecimal;
  final int? refundGrandTotal;
  final String? refundGrandTotalDecimal;

  OrderResponse(
      {required this.status,
      required this.statusCode,
      required this.message,
      required this.data,
      required this.toBeDeliveredGrandTotal,
      required this.toBeDeliveredGrandTotalDecimal,
      required this.deliveredGrandTotal,
      required this.deliveredGrandTotalDecimal,
      required this.refundGrandTotal,
      required this.refundGrandTotalDecimal});
}
