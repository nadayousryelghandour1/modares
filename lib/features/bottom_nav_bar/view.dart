import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/resources/background.dart';
import 'package:modares/features/Profile/view.dart';
import 'package:modares/features/home/view.dart';
import 'package:modares/features/search/view.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  final int initialIndex;
  const Home({super.key, this.initialIndex = 0});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexing = 0;
  bool isBack = false;

  @override
  void initState() {
    indexing = widget.initialIndex;
    super.initState();
  }

  bool isLoaded = false;

  void _onItemTapped(int index) {
    setState(() {
      indexing = index;
    });

    if (index == 1 && !isLoaded) {
      getIt<TeacherSearchBloc>().add(GetAllTeacher());
      isLoaded = true;
    }
  }

  List<Widget> screens = [StudentHome(), TeacherSearchPage(),Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        index: indexing,
        color: AppColor.primeryColorDark,
        backgroundColor: AppColor.primeryColor,
        buttonBackgroundColor: AppColor.secondaryColor,
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AppImage.homeIcon,
              colorFilter: ColorFilter.mode(
                indexing == 0 ? AppColor.primeryColor : AppColor.mainWhite,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
            labelStyle: TextStyle(
              color: indexing == 0 ? Colors.white : Color(0xff001F3F),
            ),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AppImage.searchIcon,
              colorFilter: ColorFilter.mode(
                indexing == 1 ? AppColor.primeryColor : AppColor.mainWhite,
                BlendMode.srcIn,
              ),
            ),
            label: "Explore",
            labelStyle: TextStyle(
              color: indexing == 1 ? Colors.white : Color(0xff001F3F),
            ),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AppImage.personIcon,
              colorFilter: ColorFilter.mode(
                indexing == 2 ? AppColor.primeryColor : AppColor.mainWhite,
                BlendMode.srcIn,
              ),
            ),
            label: "Explore",
            labelStyle: TextStyle(
              color: indexing == 1 ? Colors.white : Color(0xff001F3F),
            ),
          ),
          // CurvedNavigationBarItem(
          //   child: SvgPicture.asset(
          //     AppImage.personIcon,
          //     colorFilter: ColorFilter.mode(
          //       indexing == 2
          //           ? Colors.white
          //           : Color(0xff999999),
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   label: "Account",
          //   labelStyle: TextStyle(
          //     color: indexing == 2 ? Colors.white : Color(0xff001F3F),
          //   ),
          // ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(child: MudarrisBackground()),
          screens[indexing],
        ],
      ), // Show selected page
    );
  }
}
