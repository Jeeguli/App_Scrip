import 'package:app_scrip_bloc/features/app_scrip_list/data/models/app_scrip_model.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/data/services/app_scrip_service.dart';

class AppScripRepository {
  final ApiService apiService;

  AppScripRepository(this.apiService);

  Future<List<AppScripModel>> getAppScrips() async {
    return await apiService.fetchAppScrips();
  }
}
