import 'package:flutter/material.dart';

enum EdgePosition { top, bottom, left, right }

class EdgeGradientBlurWidget extends StatelessWidget {
  final EdgePosition position;
  final double size;
  final Color solidColor;
  final Color transparentColor;

  const EdgeGradientBlurWidget({
    super.key,
    required this.position,
    required this.size,
    required this.solidColor,
    required this.transparentColor,
  });

  @override
  Widget build(BuildContext context) {
    Alignment begin, end;
    Positioned positioned;

    switch (position) {
      case EdgePosition.top:
        begin = Alignment.topCenter;
        end = Alignment.bottomCenter;
        positioned = Positioned(
          left: 0,
          right: 0,
          top: -15,
          height: size,
          child: _buildGradient(begin, end),
        );
        break;
      case EdgePosition.bottom:
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
      case EdgePosition.left:
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
      case EdgePosition.right:
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
