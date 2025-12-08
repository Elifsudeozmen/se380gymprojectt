class WeightModel {
  final double weight;

  WeightModel({required this.weight});

  WeightModel copyWith(double newWeight) {
    return WeightModel(weight: newWeight);
  }
}
