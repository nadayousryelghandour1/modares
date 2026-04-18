// import 'package:final_app/core/resources/app_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class HeartButton extends StatefulWidget {
//   const HeartButton({super.key});

//   @override
//   State<HeartButton> createState() => _HeartButtonState();
// }

// class _HeartButtonState extends State<HeartButton> {
//   bool isActive = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isActive = !isActive;
//         });
//       },
//       child: SvgPicture.asset(
//          isActive ? AppImage.favFilledIcon : AppImage.favIcon,
//          colorFilter: const ColorFilter.mode(Color.fromARGB(255, 101, 11, 5), BlendMode.srcIn),
//       ),
//     );
//   }
// }
