import 'package:app_scrip_bloc/features/app_scrip_list/data/models/app_scrip_model.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/domain/repository/app_scrip_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_scrip_state.dart';

class AppScripCubit extends Cubit<AppScripState> {
  final AppScripRepository repository;
  List<AppScripModel> _allUsers = [];

  AppScripCubit(this.repository) : super(AppScripInitial()) {
    fetchAppScrips();
  }

  Future<void> fetchAppScrips() async {
    try {
      emit(AppScripLoading());
      final users = await repository.getAppScrips();
      _allUsers = users;
      emit(AppScripLoaded(users, allUsers: _allUsers));
    } catch (e) {
      emit(AppScripError(message: e.toString()));
    }
  }

  void filterUsers(String query) {
    if (state is AppScripLoaded) {
      final current = state as AppScripLoaded;
      final filtered = query.isEmpty
          ? _allUsers
          : _allUsers
                .where(
                  (u) =>
                      u.name.toLowerCase().contains(query.toLowerCase()) ||
                      u.email.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      emit(current.copyWith(users: filtered));
    }
  }

  void selectCategory(String category) {
    if (state is AppScripLoaded) {
      final currentState = state as AppScripLoaded;

      if (currentState.selectedCategoryType == category) {
        emit(
          currentState.copyWith(
            selectedCategoryType: '',
            selectedCategoryValue: '',
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            selectedCategoryType: category,
            selectedCategoryValue: '',
          ),
        );
      }
    }
  }

  void selectCategoryValue(String value) {
    if (state is AppScripLoaded) {
      final current = state as AppScripLoaded;

      final newValue = current.selectedCategoryValue == value ? '' : value;

      final filtered = newValue.isEmpty
          ? _allUsers
          : _allUsers.where((u) {
              if (current.selectedCategoryType == 'company') {
                return u.company.toLowerCase() == newValue.toLowerCase();
              } else if (current.selectedCategoryType == 'city') {
                return u.city.toLowerCase() == newValue.toLowerCase();
              }
              return true;
            }).toList();

      emit(current.copyWith(users: filtered, selectedCategoryValue: newValue));
    }
  }

  void clearCategory() {
    if (state is AppScripLoaded) {
      final current = state as AppScripLoaded;
      emit(
        current.copyWith(
          selectedCategoryType: '',
          selectedCategoryValue: '',
          users: _allUsers,
        ),
      );
    }
  }

  void selectUser(AppScripModel user) {
    if (state is AppScripLoaded) {
      final current = state as AppScripLoaded;
      emit(current.copyWith(selectedUser: user));
    }
  }
}
