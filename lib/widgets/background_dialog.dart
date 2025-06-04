import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

/// 배경 옵션을 나타내는 모델 클래스
class BackgroundOption {
  final String name; // 배경 이름
  final String icon; // 아이콘 이미지 경로
  final bool isLocked; // 잠금 여부

  BackgroundOption({
    required this.name,
    required this.icon,
    this.isLocked = false,
  });
}

/// 배경 선택 다이얼로그 위젯
class BackgroundSelectionDialog extends StatefulWidget {
  final Function(String) onBackgroundSelected; // 선택된 배경을 상위로 전달

  const BackgroundSelectionDialog(
      {super.key, required this.onBackgroundSelected});

  @override
  State<BackgroundSelectionDialog> createState() =>
      _BackgroundSelectionDialogState();
}

class _BackgroundSelectionDialogState extends State<BackgroundSelectionDialog> {
  String? selectedBackground; // 현재 선택된 배경 이름

  /// 사용 가능한 배경 목록
  final List<BackgroundOption> backgrounds = [
    BackgroundOption(name: 'None', icon: 'assets/background/none_icon.png'),
    BackgroundOption(name: 'Forest', icon: 'assets/background/forest_icon.png'),
    BackgroundOption(name: 'Flower', icon: 'assets/background/flower_icon.png'),
    BackgroundOption(
        name: 'Spring',
        icon: 'assets/background/spring_icon.png',
        isLocked: true),
    BackgroundOption(
        name: 'Stars',
        icon: 'assets/background/stars_icon.png',
        isLocked: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 315,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 타이틀과 닫기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text(
                  '배경화면',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),

            // 배경 옵션 목록
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Wrap(
                spacing: 2, // 좌우 간격
                runSpacing: 10, // 상하간격
                children: backgrounds.map((background) {
                  final isLocked = background.isLocked;

                  return GestureDetector(
                    onTap: () {
                      if (isLocked) {
                        // 잠긴 배경 클릭 시 스낵바 표시
                        ScaffoldMessenger.of(Navigator.of(context).context)
                            .showSnackBar(
                          SnackBar(
                            content: const Text(
                              '배경이 잠금 해제되지 않았습니다.',
                              style: TextStyle(color: Colors.white), // 텍스트 색상
                            ),
                            backgroundColor: Colors.red, // 배경색 빨간색
                            behavior:
                                SnackBarBehavior.floating, // 스낵바가 떠있는 형태로 표시
                            duration: const Duration(seconds: 1), // 표시 시간
                          ),
                        );
                      } else {
                        // 배경 선택 시 처리
                        setState(() {
                          selectedBackground = background.name;
                        });
                        widget.onBackgroundSelected(background.name);
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 115,
                          decoration: BoxDecoration(
                            color: selectedBackground == background.name
                                ? grey01
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Opacity(
                                opacity: isLocked ? 0.7 : 1.0, // 잠금 상태 불투명도
                                child: Image.asset(
                                  background.icon,
                                  width: 65,
                                  height: 65,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                background.name,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 잠긴 배경에 자물쇠 아이콘 표시
                        if (isLocked)
                          Positioned(
                            top: 32.5, // 중앙 위에 적절히 배치
                            child: Icon(
                              Icons.lock, // 자물쇠 아이콘
                              color: dark02, // 자물쇠 색상
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
