import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/cache_helper.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ApiConsumer api = getIt<ApiConsumer>();

  PaymentBloc() : super(PaymentInitial()) {
    on<InitiatePaymentEvent>(_onInitiatePayment);
  }

  Future<void> _onInitiatePayment(
    InitiatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading(method: event.method));

    try {
      final user = await CacheHelper.getUser();

      final response = await api.post(
        EndPoints.payment,
        data: {
          "amountCents": (event.price * 100).toInt(),
          "currency": "EGP",

          // مهم
          "customer": {
            "firstName": user.name ?? "Guest",
            "lastName": "User",
            "email": user.email ?? "guest@example.com",
            "phoneNumber": user.phoneNumber ?? "01000000000",
          },

          "items": [
            {
              "name": event.courseTitle,
              "amount": (event.price * 100).toInt(),
              "quantity": 1,
            }
          ],

          "integrationIds": [event.integrationId],

          "orderReference":
              "lecture-${event.courseId}-${event.studentId}-${DateTime.now().millisecondsSinceEpoch}",

          "redirectionUrl":
              "modares://payment/callback?studentId=${event.studentId}&lectureId=${event.courseId}",

          "notificationUrl":
              "https://modares.runasp.net/payment/webhook",
        },
      );

      final checkoutUrl = response["checkoutUrl"];

      if (checkoutUrl == null || checkoutUrl.toString().isEmpty) {
        emit(
          PaymentFailure(
            message: "لم يتم استلام رابط الدفع",
          ),
        );
        return;
      }

      emit(
        PaymentSuccess(
          checkoutUrl: checkoutUrl,
          lectureId: event.courseId,
          studentId: event.studentId,
        ),
      );
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["error"] ??
          e.message ??
          "Payment Failed";

      emit(
        PaymentFailure(
          message: errorMessage.toString(),
        ),
      );
    } on ServerException catch (e) {
      emit(
        PaymentFailure(
          message: e.errorModel.message ?? "حدث خطأ غير متوقع",
        ),
      );
    } catch (e) {
      emit(
        PaymentFailure(
          message: e.toString(),
        ),
      );
    }
  }
}