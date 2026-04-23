import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  int indexActive = 0;
  List<String> choices = ["travel", "Technology", "Business", "Entertainment"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: choices.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    indexActive = index;
                  });
                    
                
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: indexActive == index ? Colors.transparent : Colors.black,
                  ),
                  backgroundColor: indexActive == index ? AppColor.primaryTextColor : Colors.white,
                ),
                child: Text(
                  choices[index],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColor.primaryTextColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
