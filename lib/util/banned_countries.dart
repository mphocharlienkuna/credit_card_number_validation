/// A utility class for checking if a country is banned.
class BannedCountries {
  /// Checks if a country is banned.
  ///
  /// [country] The country to check.
  ///
  /// Returns `true` if the country is banned, `false` otherwise.
  static bool isCountryBanned(String country) {
    const bannedCountries = ["North Korea", "Iran", "Syria", "Cuba"];
    return bannedCountries.contains(country);
  }
}
