import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPanel extends StatelessWidget {
  final VoidCallback? onClose;
  const NotificationPanel({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/common/app_scrip_icon.svg',
                        height: 30,
                        width: 30,
                      ),
                      IconButton(
                        onPressed: onClose ?? () => context.pop(),
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'No notifications',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color(0xFFA1A1A1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
