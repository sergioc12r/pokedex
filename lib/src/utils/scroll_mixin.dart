import 'package:flutter/material.dart';

mixin ScrollMixin<T extends StatefulWidget> on State<T>{

  ScrollController controller = ScrollController();

  bool isLoading = false, hasReachedMax = false;

  double get scrollThreshold;

  onEndOfPage();

  _verifyEndOfPage(){
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    double delta = scrollThreshold;
    if(maxScroll - currentScroll <= (scrollThreshold)) onEndOfPage();
  }

  @override
  void initState() {
    controller.addListener(_verifyEndOfPage);
    super.initState();
  }


  @override
  void dispose() {
    controller.removeListener(_verifyEndOfPage);
    controller.dispose();
    super.dispose();
  }
}