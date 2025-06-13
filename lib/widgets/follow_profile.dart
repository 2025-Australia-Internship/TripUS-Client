import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class FollowProfile extends StatefulWidget {
  final String name;
  final Image image;
  final String message;
  final VoidCallback? onTap;
  final bool initialFollow;

  const FollowProfile({
    super.key,
    required this.name,
    required this.image,
    required this.message,
    required this.initialFollow,
    this.onTap,
  });

  @override
  State<FollowProfile> createState() => _FollowProfileState();
}

class _FollowProfileState extends State<FollowProfile> {
  late bool isFollow;

  @override
  void initState() {
    super.initState();
    isFollow = widget.initialFollow;
  }

  void toggleFollow() {
    setState(() {
      isFollow = !isFollow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // ← 여기에 onTap 연결
      child: SizedBox(
        width: 315,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image(
                        image: widget.image.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6e6e6e),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleFollow(); // 이건 내부에서 처리
                    },
                    child: ElevatedButton(
                      onPressed: null, // GestureDetector로 처리하므로 제거
                      style: TextButton.styleFrom(
                        backgroundColor: isFollow ? Colors.white : MainColor,
                        side: BorderSide(color: MainColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      child: Text(
                        isFollow ? '팔로우' : '팔로잉',
                        style: TextStyle(
                          color: isFollow ? dark08 : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Color(0xffE8E8E8),
            ),
          ],
        ),
      ),
    );
  }
}
