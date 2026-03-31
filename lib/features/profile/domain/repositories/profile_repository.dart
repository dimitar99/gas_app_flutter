abstract class ProfileRepository {
  Future<bool> updatePreferences(String fuel, double tankSize, double radius);
}
