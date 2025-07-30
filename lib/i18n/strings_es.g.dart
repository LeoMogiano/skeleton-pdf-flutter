///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppNavigationEs appNavigation = _TranslationsAppNavigationEs._(_root);
	@override late final _TranslationsHomeScreenEs homeScreen = _TranslationsHomeScreenEs._(_root);
	@override late final _TranslationsLevelScreenEs levelScreen = _TranslationsLevelScreenEs._(_root);
	@override late final _TranslationsInfoScreenEs infoScreen = _TranslationsInfoScreenEs._(_root);
	@override late final _TranslationsHistoryScreenEs historyScreen = _TranslationsHistoryScreenEs._(_root);
	@override late final _TranslationsConfigScreenEs configScreen = _TranslationsConfigScreenEs._(_root);
}

// Path: appNavigation
class _TranslationsAppNavigationEs implements TranslationsAppNavigationEn {
	_TranslationsAppNavigationEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get history => 'Historial';
	@override String get settings => 'Configuración';
}

// Path: homeScreen
class _TranslationsHomeScreenEs implements TranslationsHomeScreenEn {
	_TranslationsHomeScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get buttonText => 'Seleccionar Archivo PDF';
}

// Path: levelScreen
class _TranslationsLevelScreenEs implements TranslationsLevelScreenEn {
	_TranslationsLevelScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comprensión de PDF';
	@override String get subtitle => 'Selecciona un nivel de comprensión:';
	@override late final _TranslationsLevelScreenLevelsEs levels = _TranslationsLevelScreenLevelsEs._(_root);
	@override late final _TranslationsLevelScreenLevelsDescriptionEs levelsDescription = _TranslationsLevelScreenLevelsDescriptionEs._(_root);
	@override String get buttonText => 'Comprimir PDF';
}

// Path: infoScreen
class _TranslationsInfoScreenEs implements TranslationsInfoScreenEn {
	_TranslationsInfoScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compresión completada';
	@override String get subtitle => 'Archivo comprimido con éxito.';
	@override String get description => 'Se ha guardado en la carpeta de descargas.';
	@override String get originalSize => 'Tamaño\noriginal: ';
	@override String get compressedSize => 'Tamaño\ncomprimido: ';
	@override String get compressAnother => 'Comprimir otro PDF';
	@override String get viewCompressed => 'Ver PDF comprimido';
	@override String get deleteCompressed => 'Eliminar PDF comprimido';
}

// Path: historyScreen
class _TranslationsHistoryScreenEs implements TranslationsHistoryScreenEn {
	_TranslationsHistoryScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historial';
	@override String get emptyState => 'No hay archivos comprimidos aún.';
}

// Path: configScreen
class _TranslationsConfigScreenEs implements TranslationsConfigScreenEn {
	_TranslationsConfigScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configuración';
	@override String get not_configs => 'Actualmente no hay configuraciones disponibles.';
	@override String get collaborators => 'Colaboradores';
	@override String get developer => 'Desarrollador';
	@override String get designer => 'Diseñador de UI/UX';
	@override String get tester => 'Tester';
}

// Path: levelScreen.levels
class _TranslationsLevelScreenLevelsEs implements TranslationsLevelScreenLevelsEn {
	_TranslationsLevelScreenLevelsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get low => 'Baja';
	@override String get medium => 'Media';
	@override String get high => 'Alta';
}

// Path: levelScreen.levelsDescription
class _TranslationsLevelScreenLevelsDescriptionEs implements TranslationsLevelScreenLevelsDescriptionEn {
	_TranslationsLevelScreenLevelsDescriptionEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get low => 'Reducción de tamaño: 20 - 40%';
	@override String get medium => 'Reducción de tamaño: 40 - 60%';
	@override String get high => 'Reducción de tamaño: 60 - 80%';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appNavigation.home': return 'Inicio';
			case 'appNavigation.history': return 'Historial';
			case 'appNavigation.settings': return 'Configuración';
			case 'homeScreen.buttonText': return 'Seleccionar Archivo PDF';
			case 'levelScreen.title': return 'Comprensión de PDF';
			case 'levelScreen.subtitle': return 'Selecciona un nivel de comprensión:';
			case 'levelScreen.levels.low': return 'Baja';
			case 'levelScreen.levels.medium': return 'Media';
			case 'levelScreen.levels.high': return 'Alta';
			case 'levelScreen.levelsDescription.low': return 'Reducción de tamaño: 20 - 40%';
			case 'levelScreen.levelsDescription.medium': return 'Reducción de tamaño: 40 - 60%';
			case 'levelScreen.levelsDescription.high': return 'Reducción de tamaño: 60 - 80%';
			case 'levelScreen.buttonText': return 'Comprimir PDF';
			case 'infoScreen.title': return 'Compresión completada';
			case 'infoScreen.subtitle': return 'Archivo comprimido con éxito.';
			case 'infoScreen.description': return 'Se ha guardado en la carpeta de descargas.';
			case 'infoScreen.originalSize': return 'Tamaño\noriginal: ';
			case 'infoScreen.compressedSize': return 'Tamaño\ncomprimido: ';
			case 'infoScreen.compressAnother': return 'Comprimir otro PDF';
			case 'infoScreen.viewCompressed': return 'Ver PDF comprimido';
			case 'infoScreen.deleteCompressed': return 'Eliminar PDF comprimido';
			case 'historyScreen.title': return 'Historial';
			case 'historyScreen.emptyState': return 'No hay archivos comprimidos aún.';
			case 'configScreen.title': return 'Configuración';
			case 'configScreen.not_configs': return 'Actualmente no hay configuraciones disponibles.';
			case 'configScreen.collaborators': return 'Colaboradores';
			case 'configScreen.developer': return 'Desarrollador';
			case 'configScreen.designer': return 'Diseñador de UI/UX';
			case 'configScreen.tester': return 'Tester';
			default: return null;
		}
	}
}

