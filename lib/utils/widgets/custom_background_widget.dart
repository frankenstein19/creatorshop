import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../strings.dart';

class CustomBackgroundWidget extends StatelessWidget{
  final Widget child;

  const CustomBackgroundWidget({super.key,required this.child});
  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
  return SafeArea(
    child: Stack(
      children: [
        Positioned(
          top: -10,
          child: SvgPicture.asset(
            AssetsImages.backgroundImage,
            color: theme.colorScheme.background,
          ),
        ),
        child
      ],
    ),
  );
  }
}