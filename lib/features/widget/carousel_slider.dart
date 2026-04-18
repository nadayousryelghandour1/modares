// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:final_app/core/resources/app_color.dart';
// import 'package:final_app/features/widget/advertise.dart';
// import 'package:flutter/material.dart';

// class CarouselSliderCustom extends StatefulWidget {
//   const CarouselSliderCustom({super.key});

//   @override
//   State<CarouselSliderCustom> createState() => _CarouselSliderCustomState();
// }

// class _CarouselSliderCustomState extends State<CarouselSliderCustom> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 150,
//             viewportFraction: 1.0,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           items: [1, 2, 3, 4, 5].map((i) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Advertise(),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 16,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (index) {
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: _currentIndex == index ? 10 : 8,
//               height: _currentIndex == index ? 10 : 8,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _currentIndex == index
//                     ? AppColor.primeryColor
//                     : Colors.grey,
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
