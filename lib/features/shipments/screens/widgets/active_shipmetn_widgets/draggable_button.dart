import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';


class DraggableConfirmButton extends StatefulWidget {
  final String text;
  final VoidCallback onDragEnd;
  final double dragThreshold;

  DraggableConfirmButton({
    required this.text,
    required this.onDragEnd,
    this.dragThreshold = 0.8,
  });

  @override
  _DraggableConfirmButtonState createState() => _DraggableConfirmButtonState();
}

class _DraggableConfirmButtonState extends State<DraggableConfirmButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _isDragging = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _glowColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _glowColorAnimation = ColorTween(
        begin: Colors.transparent, end: Colors.white.withOpacity(0.3))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w),
      width: double.infinity,
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.sp),
        ),
        color: TColors.primary,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          AnimatedPositioned(
            left: _dragPosition * (MediaQuery.of(context).size.width - 15.w),
            top: 0,
            bottom: 0,
            duration: Duration(milliseconds: _isDragging ? 0 : 300),
            curve: Curves.easeOut,
            child: GestureDetector(
              onHorizontalDragStart: (_) {
                setState(() {
                  _isDragging = true;
                  _controller.forward();
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.primaryDelta! /
                      (MediaQuery.of(context).size.width - 15.w);
                  _dragPosition = _dragPosition.clamp(0.0, 1.0);
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  _isDragging = false;
                  _controller.reverse();
                });
                if (_dragPosition > widget.dragThreshold) {
                  widget.onDragEnd();
                  setState(() {
                    _dragPosition = 0.0;
                  });
                } else {
                  setState(() {
                    _dragPosition = 0.0;
                  });
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 10.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: _isDragging
                            ? [
                          BoxShadow(
                            color: _glowColorAnimation.value!,
                            spreadRadius: 0.2,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ]
                            : [],
                      ),
                      child: Icon(Icons.double_arrow,
                          color: _isDragging ? Colors.white : Colors.white70,
                          size: 20.sp),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
