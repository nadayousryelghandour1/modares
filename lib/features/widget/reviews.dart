// import 'package:final_app/core/resources/app_image.dart';
// import 'package:final_app/core/resources/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class Reviews extends StatelessWidget {
//   final double rating;
//   final int rewiewsNumber;
//   const Reviews({super.key , required this.rating , required this.rewiewsNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       spacing: 5,
//       children: [
//         SvgPicture.asset(AppImage.starIcon),
//         Text("$rating",style: AppTextStyle.primaryStyle.copyWith(fontSize: 16 , fontWeight: FontWeight.w600),),
//         Text("($rewiewsNumber Review)",style: AppTextStyle.secondaryStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),),
//       ],
//     );
//   }
// }