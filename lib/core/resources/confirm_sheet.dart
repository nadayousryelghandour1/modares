// import 'package:modares/core/resources/app_color.dart';
// import 'package:modares/core/resources/app_text_style.dart';
// import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';

// class ConfirmSheet extends StatelessWidget {
//   final String image;
//   final String purpose;
//   final String question;
//   final String answer;
//   final bool isBuy;
//   final void Function()? tellMe;
//   const ConfirmSheet({super.key , required this.image,required this.purpose,required this.question , required this.answer ,this.isBuy = true , required this.tellMe});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // SizedBox(
//             //   height: 100,
//             //   child: LottieBuilder.asset(image)),
//             const SizedBox(height: 16),
//              Center(
//               child: Text(purpose, style: AppTextStyle.primaryStyle),
//             ),
//             const SizedBox(height: 8),
//              Center(child: Text(question)),
//             const SizedBox(height: 24),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 GestureDetector(
//                   onTap: tellMe,
//                   child: Container(
//                     height: 54,
//                     decoration: BoxDecoration(
//                       color:isBuy?AppColor.primeryBgColor: const Color(0xffED1010),
//                       border: Border.all(color: Colors.transparent, width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child:  Center(
//                       child: Text(
//                         answer,
//                         style: AppTextStyle.advertiseText,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     height: 54,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: const Color.fromARGB(45, 0, 0, 0),
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Center(
//                       child: Text("No", style: AppTextStyle.primaryStyle),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
