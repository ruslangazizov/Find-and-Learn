//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `clock`.
    static let clock = Rswift.ImageResource(bundle: R.hostingBundle, name: "clock")
    /// Image `closed_eye`.
    static let closed_eye = Rswift.ImageResource(bundle: R.hostingBundle, name: "closed_eye")
    /// Image `opened_eye`.
    static let opened_eye = Rswift.ImageResource(bundle: R.hostingBundle, name: "opened_eye")
    /// Image `user_profile`.
    static let user_profile = Rswift.ImageResource(bundle: R.hostingBundle, name: "user_profile")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "clock", bundle: ..., traitCollection: ...)`
    static func clock(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.clock, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "closed_eye", bundle: ..., traitCollection: ...)`
    static func closed_eye(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.closed_eye, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "opened_eye", bundle: ..., traitCollection: ...)`
    static func opened_eye(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.opened_eye, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "user_profile", bundle: ..., traitCollection: ...)`
    static func user_profile(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.user_profile, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 12 localization keys.
    struct localizable {
      /// Value: E-Mail
      static let password_recovery_screen_email_placeholder = Rswift.StringResource(key: "password_recovery_screen_email_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: E-Mail
      static let registration_screen_email_placeholder = Rswift.StringResource(key: "registration_screen_email_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Введите слово
      static let dictionary_screen_search_bar_placeholder = Rswift.StringResource(key: "dictionary_screen_search_bar_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Восстановить
      static let password_recovery_screen_recovery_button = Rswift.StringResource(key: "password_recovery_screen_recovery_button", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Есть аккаунт? Войти
      static let password_recovery_screen_enter_button = Rswift.StringResource(key: "password_recovery_screen_enter_button", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Есть аккаунт? Войти
      static let registration_screen_authorization = Rswift.StringResource(key: "registration_screen_authorization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Зарегистрироваться
      static let registration_screen_registration = Rswift.StringResource(key: "registration_screen_registration", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Никнейм
      static let account_screen_user_name_placeholder = Rswift.StringResource(key: "account_screen_user_name_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Никнейм
      static let registration_screen_user_name_placeholder = Rswift.StringResource(key: "registration_screen_user_name_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Пароль
      static let registration_screen_password_placeholder = Rswift.StringResource(key: "registration_screen_password_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Повторите пароль
      static let registration_screen_confirm_password_placeholder = Rswift.StringResource(key: "registration_screen_confirm_password_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Словарь
      static let dictionary_screen_title = Rswift.StringResource(key: "dictionary_screen_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: E-Mail
      static func password_recovery_screen_email_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("password_recovery_screen_email_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "password_recovery_screen_email_placeholder"
        }

        return NSLocalizedString("password_recovery_screen_email_placeholder", bundle: bundle, comment: "")
      }

      /// Value: E-Mail
      static func registration_screen_email_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_email_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_email_placeholder"
        }

        return NSLocalizedString("registration_screen_email_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Введите слово
      static func dictionary_screen_search_bar_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("dictionary_screen_search_bar_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "dictionary_screen_search_bar_placeholder"
        }

        return NSLocalizedString("dictionary_screen_search_bar_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Восстановить
      static func password_recovery_screen_recovery_button(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("password_recovery_screen_recovery_button", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "password_recovery_screen_recovery_button"
        }

        return NSLocalizedString("password_recovery_screen_recovery_button", bundle: bundle, comment: "")
      }

      /// Value: Есть аккаунт? Войти
      static func password_recovery_screen_enter_button(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("password_recovery_screen_enter_button", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "password_recovery_screen_enter_button"
        }

        return NSLocalizedString("password_recovery_screen_enter_button", bundle: bundle, comment: "")
      }

      /// Value: Есть аккаунт? Войти
      static func registration_screen_authorization(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_authorization", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_authorization"
        }

        return NSLocalizedString("registration_screen_authorization", bundle: bundle, comment: "")
      }

      /// Value: Зарегистрироваться
      static func registration_screen_registration(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_registration", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_registration"
        }

        return NSLocalizedString("registration_screen_registration", bundle: bundle, comment: "")
      }

      /// Value: Никнейм
      static func account_screen_user_name_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("account_screen_user_name_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "account_screen_user_name_placeholder"
        }

        return NSLocalizedString("account_screen_user_name_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Никнейм
      static func registration_screen_user_name_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_user_name_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_user_name_placeholder"
        }

        return NSLocalizedString("registration_screen_user_name_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Пароль
      static func registration_screen_password_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_password_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_password_placeholder"
        }

        return NSLocalizedString("registration_screen_password_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Повторите пароль
      static func registration_screen_confirm_password_placeholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("registration_screen_confirm_password_placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "registration_screen_confirm_password_placeholder"
        }

        return NSLocalizedString("registration_screen_confirm_password_placeholder", bundle: bundle, comment: "")
      }

      /// Value: Словарь
      static func dictionary_screen_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("dictionary_screen_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "dictionary_screen_title"
        }

        return NSLocalizedString("dictionary_screen_title", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.systemIconsNames` struct is generated, and contains static references to 1 localization keys.
    struct systemIconsNames {
      /// Value: heart.fill
      static let dictionary_screen_favorite_words_button = Rswift.StringResource(key: "dictionary_screen_favorite_words_button", tableName: "SystemIconsNames", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: heart.fill
      static func dictionary_screen_favorite_words_button(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("dictionary_screen_favorite_words_button", tableName: "SystemIconsNames", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "SystemIconsNames", preferredLanguages: preferredLanguages) else {
          return "dictionary_screen_favorite_words_button"
        }

        return NSLocalizedString("dictionary_screen_favorite_words_button", tableName: "SystemIconsNames", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
