import 'package:flutter/material.dart';

enum PageEdge { left, right, bottom }

class PageEdgeBlurWidget extends StatelessWidget {
  final PageEdge edge;
  final double size;
  final Color solidColor;
  final Color transparentColor;

  const PageEdgeBlurWidget({
    super.key,
    required this.edge,
    this.size = 20,
    required this.solidColor,
    required this.transparentColor,
  });

  @override
  Widget build(BuildContext context) {
    Alignment begin, end;
    Positioned positioned;

    switch (edge) {
      case PageEdge.left:
        begin = Alignment.centerLeft;
        end = Alignment.centerRight;
        positioned = Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: size,
          child: _buildGradient(begin, end),
        );
        break;
      case PageEdge.right:
        begin = Alignment.centerRight;
        end = Alignment.centerLeft;
        positioned = Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          width: size,
          child: _buildGradient(begin, end),
        );
        break;
      case PageEdge.bottom:
        begin = Alignment.bottomCenter;
        end = Alignment.topCenter;
        positioned = Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: size,
          child: _buildGradient(begin, end),
        );
        break;
    }

    return positioned;
  }

  Widget _buildGradient(Alignment begin, Alignment end) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [
              solidColor,
              transparentColor,
            ],
          ),
        ),
      ),
    );
  }
}
