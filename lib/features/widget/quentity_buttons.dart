// import 'package:final_app/core/network/api/service_locator.dart';
// import 'package:final_app/core/resources/app_text_style.dart';
// import 'package:final_app/cubit/cart/cart_cubit.dart';
// import 'package:flutter/material.dart';

// class QuentityButtons extends StatelessWidget {
//   final int quentity;
//   final int id;
//   const QuentityButtons({super.key, required this.quentity, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     final CartCubit cubit = getIt<CartCubit>();
//     return SizedBox(
//       child: Row(
//         spacing: 10,
//         children: [
//           GestureDetector(
//             onTap: () {
//               cubit.decreaseQuantity(id);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color.fromARGB(45, 0, 0, 0),
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//                 // color: AppColor.primeryTextFormFieldBackgroundColor,
//               ),
//               child: const Text('-', style: AppTextStyle.primaryStyle),
//             ),
//           ),
//           Text('$quentity', style: AppTextStyle.primaryStyle),
//           GestureDetector(
//             onTap: () {
//               cubit.increaseQuantity(id);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color.fromARGB(45, 0, 0, 0),
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text('+', style: AppTextStyle.primaryStyle),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
