// import 'package:final_app/core/network/api/service_locator.dart';
// import 'package:final_app/core/resources/app_color.dart';
// import 'package:final_app/core/resources/app_text_style.dart';
// import 'package:final_app/cubit/cart/cart_cubit.dart';
// import 'package:final_app/features/widget/heart_button.dart';
// import 'package:final_app/model/product_model.dart';
// import 'package:flutter/material.dart';

// class Product extends StatelessWidget {
//   final String image;
//   final String title;
//   final double price;
//   final ProductModel item;
//   const Product({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.price,
//     required this.item,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final CartCubit cubitCart = getIt<CartCubit>();
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
//                 const Positioned(top: 10, right: 10, child: HeartButton()),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.min,
//             spacing: 10,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 3,
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     child: Text(
//                       title,
//                       overflow: TextOverflow.ellipsis,
//                       style: AppTextStyle.itemTitleStyle,
//                     ),
//                   ),
//                   Text("\$ $price", style: AppTextStyle.itemPriceStyle),
//                 ],
//               ),
//               CircleAvatar(
//                 radius: 12,
//                 backgroundColor: AppColor.primeryColor,
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       cubitCart.addToCart(item);
//                     },
//                     child: const Icon(Icons.add, color: AppColor.background),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
