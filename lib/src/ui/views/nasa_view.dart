// ignore_for_file: avoid_unnecessary_containers

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: library_prefixes
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba_tecnica_3a/src/ui/bloc/bottom_bar/bottom_bar_cubit.dart';
import 'package:prueba_tecnica_3a/src/ui/bloc/gift_bloc/gift_bloc.dart';

class NasaView extends StatelessWidget {
  const NasaView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _customAppBar(context),
            bottomNavigationBar: _customBottomNV(context, state),
            body: PageView(
              controller: context.read<GiftBloc>().pageController,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: _rowNameButton(context, Icons.add, 'Favorites')),
                    _buttonsTabBar(),
                    _tapBarViews(context, screenSize),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//Create the tapchips
Expanded _tapBarViews(BuildContext context, Size screenSize) {
  return Expanded(
    child: TabBarView(
      children: [
        Container(
          color: Colors.lightBlue.withOpacity(.1),
          child: const Center(
            child: Text(
              'All',
              style: TextStyle(color: Colors.orange, fontSize: 26),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _rowNameButton(
                    context, FontAwesomeIcons.trashCan, 'Happy Hour'),
              ),
              _locationCard(
                  context, screenSize, 0, 'Broken Shaker at Freehand Miami'),
              _locationCard(context, screenSize, 1, 'Esotico Miami'),
              _locationCard(context, screenSize, 2, 'Datos de API'),
              _locationCard(context, screenSize, 0, 'Datos de API'),
            ],
          ),
        ),
        Container(
          color: Colors.lightBlue.withOpacity(.1),
          child: const Center(
            child: Text(
              'Drinks',
              style: TextStyle(color: Colors.orange, fontSize: 26),
            ),
          ),
        ),
        Container(
          color: Colors.lightBlue.withOpacity(.1),
          child: const Center(
            child: Text(
              'Beer',
              style: TextStyle(color: Colors.orange, fontSize: 26),
            ),
          ),
        ),
        Container(
          color: Colors.lightBlue.withOpacity(.1),
          child: const Center(
            child: Text(
              'Whatever',
              style: TextStyle(color: Colors.orange, fontSize: 26),
            ),
          ),
        ),
      ],
    ),
  );
}

//the card with the image gif and information by the api
_locationCard(BuildContext context, Size screenSize, int index, String title) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: SizedBox(
      width: screenSize.width * .9,
      height: screenSize.height * .23,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(FontAwesomeIcons.ellipsis, color: Colors.grey)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: _gifBuild(screenSize, index, context),
                      ),
                      Positioned(
                        bottom: 0,
                        left: screenSize.width * .15,
                        child: Material(
                          borderRadius: BorderRadius.circular(30),
                          elevation: 4,
                          color: Colors.transparent,
                          child: Ink(
                            height: 35,
                            width: 35,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(FontAwesomeIcons.solidHeart,
                                    size: 18, color: Color(0xffEE7F3D)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: screenSize.width * .4,
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

//building the gif
Center _gifBuild(Size screenSize, int index, BuildContext context) {
  return Center(
    child: BlocBuilder<GiftBloc, GiftState>(
      builder: (context, state) {
        if (state is GiftInitial) {
          return const CircularProgressIndicator();
        } else if (state is GiftLoadedState) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: FadeInImage(
              placeholder: const Svg.Svg('assets/svg/nasa.svg'),
              image: NetworkImage(state.model[index].original.url!),
              width: screenSize.width * .38,
              height: screenSize.height * .14,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Container(
            child: TextButton(onPressed: () {}, child: const Text("ok")),
          );
        }
      },
    ),
  );
}

//The buttons to the tabbar, the chips
ButtonsTabBar _buttonsTabBar() {
  return ButtonsTabBar(
    radius: 15,
    elevation: 5,
    height: 60,
    buttonMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: const Color(0xffEE7F3D),
    unselectedDecoration: const BoxDecoration(color: Colors.white),
    tabs: const [
      Tab(
        text: 'All',
      ),
      Tab(
        text: 'Happy Hours',
      ),
      Tab(
        text: 'Drinks',
      ),
      Tab(
        text: 'Beer',
      ),
      Tab(
        text: 'whatever',
      ),
    ],
  );
}

//Create a AppBar
AppBar _customAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 100,
    leading: SvgPicture.asset('assets/svg/nasa.svg'),
    leadingWidth: 100,
    elevation: 0,
    backgroundColor: Colors.grey.withOpacity(.01),
    shadowColor: Colors.transparent,
    actions: [
      Center(
        child: _neumoButton(context, FontAwesomeIcons.bell),
      ),
      const SizedBox(
        width: 10,
      ),
      Center(
        child: _neumoButton(context, FontAwesomeIcons.gear),
      ),
      const SizedBox(
        width: 30,
      ),
    ],
  );
}

//creating the buttons to the appbar
_neumoButton(BuildContext context, IconData iconData) {
  return GestureDetector(
    child: Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 5,
              offset: const Offset(.1, 3),
              spreadRadius: 2)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Icon(
        iconData,
        color: Colors.black,
      ),
    ),
  );
}

//the rowname from in the title
Row _rowNameButton(BuildContext context, IconData iconData, String name) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
        ),
        _neumoButton(
          context,
          iconData,
        ),
      ]);
}

//the bottomNavigatorBar made with bottom_navy_bar package
BottomNavyBar _customBottomNV(BuildContext context, BottomBarState state) {
  return BottomNavyBar(
    items: [
      BottomNavyBarItem(
        icon: const Icon(
          FontAwesomeIcons.house,
          color: Colors.black,
        ),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        textAlign: TextAlign.center,
        activeColor: Colors.white,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          FontAwesomeIcons.calendar,
          color: Colors.black,
        ),
        title: const Text(
          'Events',
          style: TextStyle(color: Colors.black),
        ),
        textAlign: TextAlign.center,
        activeColor: Colors.white,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        activeColor: Colors.white,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          FontAwesomeIcons.heart,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
        title: const Text(
          'Favoritos',
          style: TextStyle(color: Colors.black),
        ),
        activeColor: Colors.white,
      ),
    ],
    selectedIndex: state.index!,
    onItemSelected: (index) {
      context.read<BottomBarCubit>().changePage(index);
    },
  );
}
