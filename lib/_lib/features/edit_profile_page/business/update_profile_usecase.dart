 import '../data/user_repository.dart';

class UpdateProfileUseCase {
  final UserRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(
      String name,
      String surname,
      String password,
      String height,
      String weight) async {
    await repository.updateUser(
      name: name,
      surname: surname,
      password: password,
      height: height,
      weight: weight,
    );
  }
}
