import 'package:flutter/material.dart';

import 'input_tile.dart';

class SearchBar extends StatelessWidget {
  final bool isSearching;
  SearchBar({this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimateExpansion(
          animate: isSearching,
          axisAlignment: -2.0,
          child: Search(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Search extends StatelessWidget {
  String folderName;
  @override
  Widget build(BuildContext context) {
    return InputTile(
      startIcon: Icon(Icons.search,color: Colors.black),
      callBack: (value) {
        folderName = value;
        print(folderName);
        return folderName;
      },
      inputType: 'Search Product',
    );
    // TextField(
    //   autofocus: true,
    //   decoration: InputDecoration(
    //     border: InputBorder.none,
    //     hintText: 'Search folder...',
    //     hintStyle: TextStyle(
    //       fontSize: 25,
    //       color: Colors.grey.shade100,
    //     ),
    // ),
    // );
  }
}


class AnimateExpansion extends StatefulWidget {
  final Widget child;
  final bool animate;
  final double axisAlignment;
  AnimateExpansion({
    this.animate = false,
    this.axisAlignment,
    this.child,
  });

  @override
  _AnimateExpansionState createState() => _AnimateExpansionState();
}

class _AnimateExpansionState extends State<AnimateExpansion>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  void prepareAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.bounceOut,
    );
  }

  void _toggle() {
    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _toggle();
  }

  @override
  void didUpdateWidget(AnimateExpansion oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggle();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        sizeFactor: _animation,
        child: widget.child);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
