import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/lecture_bloc.dart';
import 'package:modares/bloc/payment/payment_bloc.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/core/resources/snack_bar.dart';
import 'package:modares/features/widget/paymob.dart';
import 'package:modares/model/lecture.dart';

const _kPrimary = Color(0xFF0D1440);

class UnitDetailsPage extends StatelessWidget {
  final int unitId;
  final String unitName;

  const UnitDetailsPage({
    super.key,
    required this.unitId,
    required this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              LectureBloc()..add(GetUnitDetailsEvent(unitId: unitId)),
        ),
        BlocProvider(create: (_) => PaymentBloc()),
      ],
      child: _UnitDetailsView(unitId: unitId, unitName: unitName),
    );
  }
}

class _UnitDetailsView extends StatelessWidget {
  final int unitId;
  final String unitName;

  const _UnitDetailsView({required this.unitId, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: AppColor.mainBackground,
        title: Text(unitName, style: AppTextStyle.primaryStyle),
        centerTitle: true,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImage.mainBg, fit: BoxFit.cover),
          ),
          BlocBuilder<LectureBloc, LectureState>(
            builder: (context, state) {
              if (state is LecturesLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetLecturesFailure) {
                return Center(
                  child: Text(state.message ?? "حدث خطأ غير متوقع"),
                );
              }

              if (state is GetLecturesSuccess) {
                final lectures = state.lectures;

                if (lectures.isEmpty) {
                  return const Center(child: Text("لا توجد محاضرات"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: lectures.length,
                  itemBuilder: (context, index) {
                    return LectureCard(
                      lecture: lectures[index],
                      unitId: unitId,
                      index: index + 1,
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class LectureCard extends StatelessWidget {
  final LectureModel lecture;
  final int unitId;
  final int index;

  const LectureCard({
    super.key,
    required this.lecture,
    required this.unitId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isPurchased = lecture.isPurchased;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.mainWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.mainGray.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.secondaryLoginButtonColor,
          child: Text(
            "$index",
            style: AppTextStyle.primaryStyle.copyWith(fontSize: 14),
          ),
        ),
        title: Text(
          lecture.name,
          style: AppTextStyle.primaryStyle.copyWith(fontSize: 14),
        ),
        subtitle: lecture.description.isNotEmpty
            ? Text(
                lecture.description,
                style: AppTextStyle.secondaryStyle.copyWith(fontSize: 12),
              )
            : null,
        trailing: isPurchased
            ? Icon(Icons.play_circle_fill, color: AppColor.primeryColor)
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                ),
                onPressed: () {
                  _showPaymentSheet(context, lecture, unitId);
                },
                child: Text(
                  "اشتري",
                  style: AppTextStyle.primaryStyle.copyWith(fontSize: 12),
                ),
              ),
      ),
    );
  }

  void _showPaymentSheet(
    BuildContext context,
    LectureModel lecture,
    int unitId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<PaymentBloc>(),
        child: PaymentBottomSheet(lecture: lecture, unitId: unitId),
      ),
    );
  }
}

class PaymentBottomSheet extends StatelessWidget {
  final LectureModel lecture;
  final int unitId;

  const PaymentBottomSheet({
    super.key,
    required this.lecture,
    required this.unitId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentSuccess) {
          Navigator.pop(context);

          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => PaymobWebViewPage(
                checkoutUrl: state.checkoutUrl,
                lectureId: state.lectureId,
                studentId: state.studentId,
              ),
            ),
          );

          if (result == true && context.mounted) {
            context.read<LectureBloc>().add(
              GetUnitDetailsEvent(unitId: unitId),
            );

            showMySnackBar(
              msg: "تم الدفع بنجاح",
              type: AnimatedSnackBarType.success,
              context: context,
            );
          }
        }

        if (state is PaymentFailure) {
          showMySnackBar(
            msg: state.message,
            type: AnimatedSnackBarType.error,
            context: context,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            final isLoading = state is PaymentLoading;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lecture.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text("السعر: ${lecture.price} جنيه"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final user = await CacheHelper.getUser();

                          context.read<PaymentBloc>().add(
                            InitiatePaymentEvent(
                              method: "Card",
                              integrationId: 5633982,
                              courseTitle: lecture.name,
                              courseId: lecture.id,
                              price: lecture.price.toDouble(),
                              studentId: user.id,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "ادفع الآن",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
