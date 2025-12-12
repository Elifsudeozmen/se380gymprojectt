class BMICalculator {
String interpretBMI(double bmi) {
if (bmi < 18.5) return "You are underweight. You should gain weight.";
if (bmi < 25) return "You are in good shape. Maintain your weight!";
if (bmi < 30) return "You are overweight. Consider losing weight.";
return "You are obese. You must lose weight.";
}
}