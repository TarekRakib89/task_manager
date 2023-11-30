// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyBackground extends StatelessWidget {
  const BodyBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}
