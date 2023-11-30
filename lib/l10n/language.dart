class Language {
  final String name;
  final String languageCode;

  Language({
    required this.name,
    required this.languageCode,
  });

  static List<Language> languageList() {
    return <Language>[
      Language(name: 'Español', languageCode: 'es'),
      Language(name: 'English', languageCode: 'en'),
      Language(name: 'Deutsch', languageCode: 'de'),
    ];
  }
}
