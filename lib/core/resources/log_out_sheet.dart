// import 'package:final_app/core/resources/app_text_style.dart';
// import 'package:final_app/core/resources/cache_helper.dart';
// import 'package:final_app/features/login/view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class LogOutSheet extends StatelessWidget {
//   final String image;
//   final String purpose;
//   final String question;
//   final String answer;
//   const LogOutSheet({super.key , required this.image,required this.purpose,required this.question , required this.answer});

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
//             CircleAvatar(
//               radius: 28,
//               backgroundColor: const Color.fromARGB(85, 237, 16, 16),
//               child: SvgPicture.asset(image),
//             ),
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
//                   onTap: () {
//                     CacheHelper.delete();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Login()),
//                     );
//                   },
//                   child: Container(
//                     height: 54,
//                     decoration: BoxDecoration(
//                       color: const Color(0xffED1010),
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
