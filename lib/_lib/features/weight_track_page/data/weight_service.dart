
import 'package:gymproject/_lib/features/weight_track_page/business/weight_model.dart';

class WeightService {
  WeightModel _userWeight = WeightModel(weight: 72);

  Future<WeightModel> loadUserWeight() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _userWeight;
  }

  Future<void> updateWeight(double newWeight) async {
    _userWeight = WeightModel(weight: newWeight);
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
