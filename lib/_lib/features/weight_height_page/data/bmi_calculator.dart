class BMICalculator {
  double calculateBMI(double height, double weight) {
    if (height <= 0) return 0;
    double heightMeter = height / 100;
    return weight / (heightMeter * heightMeter);
  }
}
