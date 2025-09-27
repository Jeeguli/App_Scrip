import 'dart:math';
import 'package:app_scrip_bloc/constants/profile_svg.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/data/models/app_scrip_model.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_cubit.dart';
import 'package:app_scrip_bloc/routes/app_routes_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDataListView extends StatelessWidget {
  final List<AppScripModel> users;
  const UserDataListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: users.map((user) {
            final svgPath = profileSvgs[random.nextInt(profileSvgs.length)];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFA1A1A1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFF245AE9),
                    child: SvgPicture.asset(svgPath, height: 40, width: 40),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF252525),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.email,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFFA1A1A1),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final cubit = context.read<AppScripCubit>();
                                cubit.selectUser(user);
                                context.push(AppRoutesString.userDetailsScreen);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF245AE9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
