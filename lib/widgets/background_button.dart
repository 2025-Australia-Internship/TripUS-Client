import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/background_dialog.dart';

/// 배경 선택 다이얼로그를 띄우는 버튼 위젯
class BackgroundButton extends StatelessWidget {
  final Function(String) onBackgroundSelected; // 선택된 배경 콜백 전달

  const BackgroundButton({super.key, required this.onBackgroundSelected});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: light08,
      child: IconButton(
        onPressed: () {
          // 다이얼로그 띄우기
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackgroundSelectionDialog(
                onBackgroundSelected: onBackgroundSelected,
              );
            },
          );
        },
        icon: SvgPicture.asset(
          'assets/home/edit.svg',
          width: 20,
        ),
      ),
    );
  }
}
