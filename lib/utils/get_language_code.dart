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
