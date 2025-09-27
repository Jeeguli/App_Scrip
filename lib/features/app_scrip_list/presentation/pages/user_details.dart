import 'dart:math';
import 'package:app_scrip_bloc/constants/profile_svg.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_cubit.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_state.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/widgets/notification_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 9,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.blueAccent),
            SizedBox(width: 10),
            SizedBox(
              width: 120,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF252525),
                ),
              ),
            ),
            Text(
              ":",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Color(0xFF252525),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF535353),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFF6F5FF),
      ),
    );
    final cubit = context.read<AppScripCubit>();
    final user = (cubit.state as AppScripLoaded).selectedUser;
    final random = Random();

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Text("No user selected")),
      );
    }

    final svgPath = profileSvgs[random.nextInt(profileSvgs.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/common/bg1.svg',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 16,
                    right: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/common/app_scrip_icon.svg',
                          height: 40,
                          width: 40,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              barrierLabel: "Notifications",
                              barrierDismissible: true,
                              barrierColor: Colors.black.withAlpha(74),
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder: (_, __, ___) =>
                                  const NotificationPanel(),
                              transitionBuilder: (_, anim, __, child) {
                                final offsetAnim = Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(anim);
                                return SlideTransition(
                                  position: offsetAnim,
                                  child: child,
                                );
                              },
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/common/notification.svg',
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF245AE9),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.close,
                            size: 25,
                            color: Color(0xFF245AE9),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: 100, // CircleAvatar diameter
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background SVG inside the circle
                          ClipOval(
                            child: SvgPicture.asset(
                              'assets/common/bg1.svg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Profile SVG on top
                          SvgPicture.asset(svgPath, width: 60, height: 60),
                        ],
                      ),
                    ),
                  ),

                  // Name & Email
                  Positioned(
                    top: 270,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF252525),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Details Container
                  Positioned(
                    top: 350,
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailRow(Icons.person, 'Username', user.username),
                          _detailRow(Icons.phone, 'Phone', user.phone),
                          _detailRow(Icons.web, 'Website', user.website),
                          _detailRow(Icons.business, 'Company', user.company),
                          _detailRow(
                            Icons.comment,
                            'Catch Phrase',
                            user.companyCatchPhrase,
                          ),
                          _detailRow(Icons.work, 'BS', user.companyBs),
                          _detailRow(Icons.home, 'Street', user.street),
                          _detailRow(Icons.location_city, 'Suite', user.suite),
                          _detailRow(Icons.location_on, 'City', user.city),
                          _detailRow(
                            Icons.markunread_mailbox,
                            'Zipcode',
                            user.zipcode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
