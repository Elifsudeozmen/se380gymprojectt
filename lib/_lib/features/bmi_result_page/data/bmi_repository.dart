class BMIRepository {
double calculateBMI(double height, double weight) {
if (height == 0) return 0;
return weight / ((height / 100) * (height / 100));
}
}