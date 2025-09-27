import 'package:app_scrip_bloc/features/app_scrip_list/data/models/app_scrip_model.dart';

abstract class AppScripState {}

class AppScripInitial extends AppScripState {}

class AppScripLoading extends AppScripState {}

class AppScripLoaded extends AppScripState {
  final List<AppScripModel> users;
  final List<AppScripModel> allUsers;
  final String selectedCategoryType;
  final String selectedCategoryValue;
  final AppScripModel? selectedUser;

  AppScripLoaded(
    this.users, {
    required this.allUsers,
    this.selectedCategoryType = '',
    this.selectedCategoryValue = '',
    this.selectedUser,
  });

  AppScripLoaded copyWith({
    List<AppScripModel>? users,
    List<AppScripModel>? allUsers,
    String? selectedCategoryType,
    String? selectedCategoryValue,
    AppScripModel? selectedUser,
  }) {
    return AppScripLoaded(
      users ?? this.users,
      allUsers: allUsers ?? this.allUsers,
      selectedCategoryType: selectedCategoryType ?? this.selectedCategoryType,
      selectedCategoryValue:
          selectedCategoryValue ?? this.selectedCategoryValue,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }
}

class AppScripError extends AppScripState {
  final String message;
  AppScripError({required this.message});
}
