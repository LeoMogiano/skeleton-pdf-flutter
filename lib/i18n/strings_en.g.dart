///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppNavigationEn appNavigation = TranslationsAppNavigationEn._(_root);
	late final TranslationsHomeScreenEn homeScreen = TranslationsHomeScreenEn._(_root);
	late final TranslationsLevelScreenEn levelScreen = TranslationsLevelScreenEn._(_root);
	late final TranslationsInfoScreenEn infoScreen = TranslationsInfoScreenEn._(_root);
	late final TranslationsHistoryScreenEn historyScreen = TranslationsHistoryScreenEn._(_root);
	late final TranslationsConfigScreenEn configScreen = TranslationsConfigScreenEn._(_root);
}

// Path: appNavigation
class TranslationsAppNavigationEn {
	TranslationsAppNavigationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: homeScreen
class TranslationsHomeScreenEn {
	TranslationsHomeScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select PDF File'
	String get buttonText => 'Select PDF File';
}

// Path: levelScreen
class TranslationsLevelScreenEn {
	TranslationsLevelScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PDF Compression'
	String get title => 'PDF Compression';

	/// en: 'Select a compression level:'
	String get subtitle => 'Select a compression level:';

	late final TranslationsLevelScreenLevelsEn levels = TranslationsLevelScreenLevelsEn._(_root);
	late final TranslationsLevelScreenLevelsDescriptionEn levelsDescription = TranslationsLevelScreenLevelsDescriptionEn._(_root);

	/// en: 'Compress PDF'
	String get buttonText => 'Compress PDF';
}

// Path: infoScreen
class TranslationsInfoScreenEn {
	TranslationsInfoScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compression Completed'
	String get title => 'Compression Completed';

	/// en: 'File successfully compressed.'
	String get subtitle => 'File successfully compressed.';

	/// en: 'It has been saved in the downloads folder.'
	String get description => 'It has been saved in the downloads folder.';

	/// en: 'Original size: '
	String get originalSize => 'Original size: ';

	/// en: 'Compressed size: '
	String get compressedSize => 'Compressed size: ';

	/// en: 'Compress another PDF'
	String get compressAnother => 'Compress another PDF';

	/// en: 'View compressed PDF'
	String get viewCompressed => 'View compressed PDF';

	/// en: 'Delete compressed PDF'
	String get deleteCompressed => 'Delete compressed PDF';
}

// Path: historyScreen
class TranslationsHistoryScreenEn {
	TranslationsHistoryScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History'
	String get title => 'History';

	/// en: 'No compressed files yet.'
	String get emptyState => 'No compressed files yet.';
}

// Path: configScreen
class TranslationsConfigScreenEn {
	TranslationsConfigScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'No configurations currently available.'
	String get not_configs => 'No configurations currently available.';

	/// en: 'Collaborators'
	String get collaborators => 'Collaborators';

	/// en: 'Developer'
	String get developer => 'Developer';

	/// en: 'UI/UX Designer'
	String get designer => 'UI/UX Designer';

	/// en: 'Tester'
	String get tester => 'Tester';

	/// en: 'Language'
	String get language => 'Language';

	late final TranslationsConfigScreenLanguageOptionsEn languageOptions = TranslationsConfigScreenLanguageOptionsEn._(_root);
}

// Path: levelScreen.levels
class TranslationsLevelScreenLevelsEn {
	TranslationsLevelScreenLevelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Low'
	String get low => 'Low';

	/// en: 'Medium'
	String get medium => 'Medium';

	/// en: 'High'
	String get high => 'High';
}

// Path: levelScreen.levelsDescription
class TranslationsLevelScreenLevelsDescriptionEn {
	TranslationsLevelScreenLevelsDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Size Reduction: 20 - 40%'
	String get low => 'Size Reduction: 20 - 40%';

	/// en: 'Size Reduction: 40 - 60%'
	String get medium => 'Size Reduction: 40 - 60%';

	/// en: 'Size Reduction: 60 - 80%'
	String get high => 'Size Reduction: 60 - 80%';
}

// Path: configScreen.languageOptions
class TranslationsConfigScreenLanguageOptionsEn {
	TranslationsConfigScreenLanguageOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get en => 'English';

	/// en: 'Spanish'
	String get es => 'Spanish';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appNavigation.home': return 'Home';
			case 'appNavigation.history': return 'History';
			case 'appNavigation.settings': return 'Settings';
			case 'homeScreen.buttonText': return 'Select PDF File';
			case 'levelScreen.title': return 'PDF Compression';
			case 'levelScreen.subtitle': return 'Select a compression level:';
			case 'levelScreen.levels.low': return 'Low';
			case 'levelScreen.levels.medium': return 'Medium';
			case 'levelScreen.levels.high': return 'High';
			case 'levelScreen.levelsDescription.low': return 'Size Reduction: 20 - 40%';
			case 'levelScreen.levelsDescription.medium': return 'Size Reduction: 40 - 60%';
			case 'levelScreen.levelsDescription.high': return 'Size Reduction: 60 - 80%';
			case 'levelScreen.buttonText': return 'Compress PDF';
			case 'infoScreen.title': return 'Compression Completed';
			case 'infoScreen.subtitle': return 'File successfully compressed.';
			case 'infoScreen.description': return 'It has been saved in the downloads folder.';
			case 'infoScreen.originalSize': return 'Original size: ';
			case 'infoScreen.compressedSize': return 'Compressed size: ';
			case 'infoScreen.compressAnother': return 'Compress another PDF';
			case 'infoScreen.viewCompressed': return 'View compressed PDF';
			case 'infoScreen.deleteCompressed': return 'Delete compressed PDF';
			case 'historyScreen.title': return 'History';
			case 'historyScreen.emptyState': return 'No compressed files yet.';
			case 'configScreen.title': return 'Settings';
			case 'configScreen.not_configs': return 'No configurations currently available.';
			case 'configScreen.collaborators': return 'Collaborators';
			case 'configScreen.developer': return 'Developer';
			case 'configScreen.designer': return 'UI/UX Designer';
			case 'configScreen.tester': return 'Tester';
			case 'configScreen.language': return 'Language';
			case 'configScreen.languageOptions.en': return 'English';
			case 'configScreen.languageOptions.es': return 'Spanish';
			default: return null;
		}
	}
}

