String? getLanguageCode(String language) {
  switch (language) {
    case 'English (US)':
      return 'en_US';
    case 'English (UK)':
      return 'en_GB';
    case 'French':
      return 'fr';
    case 'German':
      return 'de';
    case 'Italian':
      return 'it';
    case 'Hindi':
      return 'hi';
    case 'Russian':
      return 'ru';
    case 'Spanish':
      return 'es';
    case 'Korean':
      return 'ko';
    case 'Arabic':
      return 'ar';
    case 'Japanese':
      return 'ja';
  }
  return null;
}

Map<String, String> languageCodeToLanguage = {
  'en_US': 'English (US)',
  'en_GB': 'English (UK)',
  'fr': 'French',
  'de': 'German',
  'it': 'Italian',
  'hi': 'Hindi',
  'ru': 'Russian',
  'es': 'Spanish',
  'ko': 'Korean',
  'ar': 'Arabic',
  'ja': 'Japanese',
};
