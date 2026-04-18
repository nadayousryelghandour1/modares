// import 'package:final_app/core/resources/app_text_style.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final String image;
  final String title;
  const ItemCategory({super.key ,required this.image, required this.title });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: SizedBox(
              width: 160,
              height: 135,
                      
              child: Center(child: Image.network(image, fit: BoxFit.contain)),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              // style: AppTextStyle.itemTitleStyle,
            ),
          ),

        ],
      ),
    );
  }
}
