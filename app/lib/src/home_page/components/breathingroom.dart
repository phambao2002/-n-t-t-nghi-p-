import 'package:flutter/material.dart';

// import 'package:app/pages/homePage.dart';
class BreathingRoom extends SliverFixedExtentList {
  BreathingRoom(double height, {Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Container();
            },
            childCount: 1,
          ),
          itemExtent: height,
        );
}
