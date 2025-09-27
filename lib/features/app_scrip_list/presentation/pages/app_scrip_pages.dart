import 'package:app_scrip_bloc/features/app_scrip_list/presentation/widgets/category_tab_widget.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/widgets/notification_panel.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/widgets/sub_category_tab_widget.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/widgets/user_data_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_cubit.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/cubit/app_scrip_state.dart';

class AppScripScreen extends StatelessWidget {
  const AppScripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppScripCubit>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<AppScripCubit, AppScripState>(
          builder: (context, state) {
            if (state is AppScripLoading) {
              return _onRefresh(context);
            } else if (state is AppScripError) {
              return _onError(state);
            } else if (state is AppScripLoaded) {
              return _AppScripView(state: state);
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () => cubit.fetchAppScrips(),
                  child: const Text("Load Users"),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _onError(AppScripError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/common/404.svg", height: 200, width: 200),
          SizedBox(height: 10),
          Text(
            "Error: ${state.message}",
            style: GoogleFonts.mulish(
              color: const Color(0xFF252525),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onRefresh(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(),
          const SizedBox(height: 30),
          _SearchField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(child: CircularProgressIndicator(color: Color(0xFF308BF9))),
        ],
      ),
    );
  }
}

class _AppScripView extends StatelessWidget {
  final AppScripLoaded state;
  const _AppScripView({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppScripCubit>();
    final companies = state.allUsers.map((u) => u.company).toSet().toList();
    final cities = state.allUsers.map((u) => u.city).toSet().toList();

    return RefreshIndicator(
      onRefresh: () async => cubit.fetchAppScrips(),
      backgroundColor: Color(0xFFFFFFFF),
      color: Color(0xFF245AE9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _HeaderRow(),
            const SizedBox(height: 30),
            _SearchField(),
            const SizedBox(height: 20),
            CategoryTabWidget(state: state),
            const SizedBox(height: 10),
            if (state.selectedCategoryType == 'company')
              SubCategoryTabWidget(
                items: companies,
                selectedValue: state.selectedCategoryValue,
                onTap: cubit.selectCategoryValue,
              ),
            if (state.selectedCategoryType == 'city')
              SubCategoryTabWidget(
                items: cities,
                selectedValue: state.selectedCategoryValue,
                onTap: cubit.selectCategoryValue,
              ),
            const SizedBox(height: 20),
            UserDataListView(users: state.users),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/common/app_scrip_icon.svg',
          height: 50,
          width: 50,
        ),
        GestureDetector(
          onTap: () {
            showGeneralDialog(
              context: context,
              barrierLabel: "Notifications",
              barrierDismissible: true,
              barrierColor: Colors.black.withAlpha(74),
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) => const NotificationPanel(),
              transitionBuilder: (_, anim, __, child) {
                final offsetAnim = Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(anim);
                return SlideTransition(position: offsetAnim, child: child);
              },
            );
          },
          child: SvgPicture.asset(
            'assets/common/notification.svg',
            colorFilter: const ColorFilter.mode(
              Color(0xFF245AE9),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppScripCubit>();
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Search users",
        hintStyle: GoogleFonts.mulish(
          color: const Color(0xFF252525),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            "assets/common/search_icon.svg",
            height: 24,
            width: 24,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF9BB8F2), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF245AE9), width: 2),
        ),
      ),
      onChanged: (query) => cubit.filterUsers(query),
    );
  }
}
