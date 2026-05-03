part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class InitiatePaymentEvent extends PaymentEvent {
  final String method;
  final int integrationId;
  final String courseTitle;
  final int courseId;
  final double price;
  final int studentId;

  InitiatePaymentEvent({
    required this.method,
    required this.integrationId,
    required this.courseTitle,
    required this.courseId,
    required this.price,
    required this.studentId,
  });
}