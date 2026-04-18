// import 'package:final_app/core/resources/app_text_style.dart';
// import 'package:final_app/features/widget/heart_button.dart';
// import 'package:flutter/material.dart';

// class ItemBuilder extends StatelessWidget {
//   final String image;
//   final String title;
//   final double price;
//   const ItemBuilder({super.key ,required this.image, required this.title , required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 5,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadiusGeometry.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//             ),
//             child: Stack(
//               children: [
//                 SizedBox(
//                   width: 160,
//                   height: 135,
          
//                   child: Image.network(image, fit: BoxFit.fill),
//                 ),
//                 const Positioned(
//                   top: 10,
//                   right: 10,
//                   child: HeartButton(),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 150,
//             child: Text(
//               title,
//               overflow: TextOverflow.ellipsis,
//               style: AppTextStyle.itemTitleStyle,
//             ),
//           ),
//           Text(
//             "\$ $price",
//             style: AppTextStyle.itemPriceStyle,
//           )
//         ],
//       ),
//     );
//   }
// }
