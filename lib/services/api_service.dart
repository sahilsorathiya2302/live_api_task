import "package:dio/dio.dart";
import 'package:milk_ride_live_wc/core/common_model/api_response_model.dart';
import 'package:milk_ride_live_wc/core/secret/end_points.dart';
import 'package:milk_ride_live_wc/core/secret/server_config.dart';
import 'package:milk_ride_live_wc/core/storage/storage_manager.dart';
import 'package:milk_ride_live_wc/features/auth/data/models/get_area_model.dart';
import 'package:milk_ride_live_wc/features/auth/data/models/otp_model.dart';
import 'package:milk_ride_live_wc/features/auth/data/models/regions_source_model.dart';
import 'package:milk_ride_live_wc/features/auth/data/models/register_model.dart';
import 'package:milk_ride_live_wc/features/cart/data/models/cart_model.dart';
import 'package:milk_ride_live_wc/features/home/data/models/home_model.dart';
import 'package:milk_ride_live_wc/features/order/data/models/order_model.dart';
import 'package:milk_ride_live_wc/features/product/data/models/categories_product_model.dart';
import 'package:milk_ride_live_wc/features/product/data/models/product_model.dart';
import 'package:milk_ride_live_wc/features/product/data/models/variant_model.dart';
import 'package:milk_ride_live_wc/features/product/data/models/view_category_model.dart';
import 'package:milk_ride_live_wc/features/subscription/data/models/subscription_model.dart';
import 'package:milk_ride_live_wc/services/interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../features/auth/data/models/sign_in_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ServerConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) {
    final String? token = StorageManager.readData("token");

    dio.options = BaseOptions(
      baseUrl: ServerConfig.baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      headers: {
        if (token != null) "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    final interceptor = DefaultInterceptor();
    dio.interceptors.add(interceptor);

    dio.interceptors.add(
      PrettyDioLogger(
        responseHeader: true,
        responseBody: true,
        requestHeader: true,
        requestBody: true,
      ),
    );

    return _ApiService(dio);
  }

  @POST(ServerConfig.milkRideVersion + EndPoints.signInPath)
  Future<SignInModel> postSignInData({
    @Field("mobile_number") required String mobileNumber,
    @Field("user_id") required String userId,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.otp)
  Future<OtpVerifyModel> checkOtp({
    @Field("mobile_number") required String mobileNumber,
    @Field("user_id") required int userId,
    @Field("otp") required String otp,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.resendOtp)
  Future<ApiResponseModel> resendOtp({
    @Field("mobile_number") required String mobileNumber,
    @Field("user_id") required int userId,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.register)
  Future<RegisterModel> register({
    @Field("name") required String name,
    @Field("email") required String? email,
    @Field("source_id") required String sourceId,
    @Field("address[area_id]") required String areaId,
    @Field("address[house_no]") required String houseNo,
    @Field("address[floor]") String? floor,
    @Field("address[society]") String? society,
    @Field("address[landmark]") String? landMark,
    @Field("address[latitude]") String? city,
    @Field("address[longitude]") String? area,
    @Field("address[pincode]") String? pinCode,
    @Field("region_id") String? regionId,
    @Field("user_id") String? userId,
    @Field("customer_referrer_code") String? referrerCode,
    @Field("agent_code") String? agentCode,
    @Field("delivery_type") String? deliveryType,
    @Field("gender") String? gender,
    @Field("mobile_number") required String mobileNumber,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.signUp)
  Future<RegionsSourceModel> fetchRegionsSourceData({
    @Field("mobile_number") required String mobileNumber,
    @Field("user_id") required int userId,
  });

  @GET(ServerConfig.customerVersion + EndPoints.getAreas)
  Future<List<GetAreaModel>> getAreas({@Path("id") required int id});

  @POST(ServerConfig.milkRideVersion + EndPoints.home)
  Future<HomeModel> getHomeData({
    @Field("mobile_number") required String mobileNumber,
    @Field("user_id") required int userId,
    @Field("type") required String type,
    @Field("device_type") required String deviceType,
    @Field("device_model") required String devicesModel,
    @Field("version") required String version,
    @Field("device_id") required String devicesId,
  });
  @POST(ServerConfig.milkRideVersion + EndPoints.allCategory)
  Future<ViewCategoryModel> viewAllCategories(
      {@Field("user_id") required int userId});

  @POST(ServerConfig.milkRideVersion + EndPoints.categoryProduct)
  Future<CategoriesProductModel> categoryProduct({
    @Field("customer_id") required int customerId,
    @Field("category_id") required int categoryId,
  });

  @GET(ServerConfig.productVersion + EndPoints.productVariants)
  Future<VariantModel> variants({
    @Query("customer_id") required int customerId,
    @Query("product_id") required int productId,
  });

  @GET(ServerConfig.productVersion + EndPoints.product)
  Future<ProductModel> product({
    @Query("customer_id") required int customerId,
    @Query("product_id") required int productId,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.subscription)
  Future<SubscriptionModel> createSubscription({
    @Field("package_id") required int packageId,
    @Field("customer_id") required int customerId,
    @Field("user_id") required int userId,
    @Field("frequency_type") required String frequencyType,
    @Field("frequency_value") required dynamic frequencyValue,
    @Field("qty") required int quantity,
    @Field("schedule") required String schedule,
    @Field("day_wise_quantity") required List<int> dayWiseQuantity,
    @Field("delivery_type") required String deliveryType,
    @Field("start_date") required String startDate,
    @Field("end_date") required String endDate,
    @Field("trial_product") required int trialProduct,
    @Field("no_of_usages") required int noOfUsages,
    @Field("product_id") required int productId,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.addToCart)
  Future<CartModel> addToCart({
    @Field("customer_id") required int customerId,
  });
  @POST(ServerConfig.milkRideVersion + EndPoints.removeCartItem)
  Future<ApiResponseModel> removeCartItem({
    @Field("cart_id") required int cartId,
  });

  @POST(ServerConfig.milkRideVersion + EndPoints.updateCartItemQty)
  Future<ApiResponseModel> updateCartItemQty({
    @Field("cart") required String cart,
  });
  @POST(ServerConfig.milkRideVersion + EndPoints.placeOrder)
  Future<ApiResponseModel> placeOrder({
    @Field("user_id") required int userId,
    @Field("customer_id") required int customerId,
  });
  @POST(ServerConfig.milkRideVersion + EndPoints.orders)
  Future<OrderModel> orders({
    @Field("delivery_date") required String deliveryDate,
    @Field("customer_id") required int customerId,
  });
  @POST(ServerConfig.milkRideVersion + EndPoints.cancelOrder)
  Future<ApiResponseModel> cancelOrder({
    @Field("order_id") required int orderId,
    @Field("package_id") required int packageId,
    @Field("reason_id") required int? reasonId,
  });
}
