import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_cubit.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTabWidget extends StatelessWidget {
  final AppScripLoaded state;
  const CategoryTabWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppScripCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => cubit.selectCategory("company"),
          child: _buildTab("Company", state.selectedCategoryType == "company"),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => cubit.selectCategory("city"),
          child: _buildTab("City", state.selectedCategoryType == "city"),
        ),
        const Spacer(),
        if (state.selectedCategoryType.isNotEmpty)
          InkWell(
            onTap: () => cubit.clearCategory(),
            child: Text(
              "Clear",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: const Color(0xFF245AE9),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTab(String text, bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF245AE9) : Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF245AE9)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: selected ? Color(0xFFFFFFFF) : const Color(0xFF245AE9),
        ),
      ),
    );
  }
}
