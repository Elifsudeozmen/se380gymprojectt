class UserRepository {
  Future<void> updateUser({
    required String name,
    required String surname,
    required String password,
    required String height,
    required String weight,
  }) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
