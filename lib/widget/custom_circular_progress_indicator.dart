import 'package:flutter/material.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
    key: key,
    child: const SizedBox.square(
      dimension: kToolbarHeightDiv3,
      child: CircularProgressIndicator(
        strokeAlign: BorderSide.strokeAlignCenter,
        color: Colors.white,
        strokeWidth: 1,
      ),
    ),
  );
}
