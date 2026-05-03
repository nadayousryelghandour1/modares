part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {
  final String method;

  PaymentLoading({required this.method});
}

class PaymentSuccess extends PaymentState {
  final String checkoutUrl;
  final int lectureId;
  final int studentId;

  PaymentSuccess({
    required this.checkoutUrl,
    required this.lectureId,
    required this.studentId,
  });
}

class PaymentFailure extends PaymentState {
  final String message;
  final Map<String, dynamic>? errors;

  PaymentFailure({
    required this.message,
    this.errors,
  });
}