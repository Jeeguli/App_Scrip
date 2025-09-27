import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryTabWidget extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function(String) onTap;

  const SubCategoryTabWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final item = items[index];
          final selected = selectedValue == item;
          return GestureDetector(
            onTap: () => onTap(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF245AE9) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF245AE9)),
              ),
              child: Center(
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: selected ? Colors.white : const Color(0xFF245AE9),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
