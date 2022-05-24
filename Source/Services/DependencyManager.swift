//
//  DependencyManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 21.05.2022.
//

import Swinject

enum DependencyManager {
    static func registerAll() -> Container {
        let container = Container()
        
        registerServices(using: container)
        registerEntranceFlow(using: container)
        registerDictionaryFlow(using: container)
        
        return container
    }
    
    // swiftlint:disable force_unwrapping
    private static func registerEntranceFlow(using container: Container) {
        container.register(AuthorizationViewInput.self) { resolver in
            let interactor = AuthorizationInteractor(
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!,
                networkManager: resolver.resolve(NetworkManagerProtocol.self)!,
                userManager: resolver.resolve(UserManagerProtocol.self)!,
                tokensManager: resolver.resolve(TokensManagerProtocol.self)!
            )
            let router = AuthorizationRouter(container: container)
            let presenter = AuthorizationPresenter(interactor: interactor, router: router)
            let viewController = AuthorizationViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(RegistrationViewInput.self) { resolver in
            let interactor = RegistrationInteractor(
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!,
                networkManager: resolver.resolve(NetworkManagerProtocol.self)!,
                userManager: resolver.resolve(UserManagerProtocol.self)!,
                tokensManager: resolver.resolve(TokensManagerProtocol.self)!
            )
            let router = RegistrationRouter(container: container)
            let presenter = RegistrationPresenter(interactor: interactor, router: router)
            let viewController = RegistrationViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(PasswordRecoveryViewInput.self) { resolver in
            let interactor = PasswordRecoveryInteractor(
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!
            )
            let router = PasswordRecoveryRouter(container: container)
            let presenter = PasswordRecoveryPresenter(interactor: interactor, router: router)
            let viewController = PasswordRecoveryViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
    }
    
    private static func registerDictionaryFlow(using container: Container) {
        container.register(SearchWordsViewInput.self) { resolver in
            let interactor = SearchWordsInteractor(
                tokensManager: resolver.resolve(TokensManagerProtocol.self)!,
                networkManager: resolver.resolve(NetworkManagerProtocol.self)!,
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!
            )
            let router = SearchWordsRouter(container: container)
            let presenter = SearchWordsPresenter(router: router, interactor: interactor)
            let viewController = SearchWordsViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(FavoriteWordsViewInput.self) { resolver in
            let interactor = FavoriteWordsInteractor(
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!
            )
            let router = FavoriteWordsRouter()
            let presenter = FavoriteWordsPresenter(router: router, interactor: interactor)
            let viewController = FavoriteWordsViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(HistoryWordsViewInput.self) { resolver in
            let interactor = HistoryWordsInteractor(
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!
            )
            let router = HistoryWordsRouter()
            let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
            let viewController = HistoryWordsViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(WordDetailViewInput.self) { (resolver, arg1: WordModel) in
            let interactor = WordDetailInteractor(
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!
            )
            let router = WordDetailRouter()
            let presenter = WordDetailPresenter(interactor: interactor, router: router, wordModel: arg1)
            let view = WordDetailViewController(presenter: presenter)
            
            presenter.view = view
            router.view = view
            
            return view
        }
        
        container.register(NewFlashcardViewInput.self) { (resolver, arg1: NewFlashcardModel, arg2: Int?) in
            let interactor = NewFlashcardInteractor(
                decksRepository: resolver.resolve(DecksRepositoryProtocol.self)!,
                flashcardsRepository: resolver.resolve(FlashcardsRepositoryProtocol.self)!
            )
            let router = NewFlashcardRouter()
            let presenter = NewFlashcardPresenter(interactor: interactor, router: router, selectedDeckId: arg2)
            let viewController = NewFlashcardViewController(presenter: presenter, newFlashcardModel: arg1)
            
            router.view = viewController
            presenter.view = viewController
            
            return viewController
        }
    }
    
    private static func registerServices(using container: Container) {
        container.register(UserManagerProtocol.self) { _ in UserManager() }.inObjectScope(.container)
        container.register(NetworkManagerProtocol.self) { _ in NetworkManager() }
        container.register(StringFormatterProtocol.self) { _ in StringFormatter() }.inObjectScope(.container)
        container.register(AchievementsManagerProtocol.self) { _ in AchievementsManager() }.inObjectScope(.container)
        container.register(StudyingManagerProtocol.self) { _ in StudyingManager() }
        container.register(SettingsManagerProtocol.self) { _ in SettingsManager() }.inObjectScope(.container)
        container.register(ValidationManagerProtocol.self) { _ in ValidationManager() }.inObjectScope(.container)
        container.register(TokensManagerProtocol.self) { _ in TokensManager() }.inObjectScope(.container)
        
        container.register(CoreDataManagerProtocol.self) { _ in CoreDataManager.shared }.inObjectScope(.container)
        container.register(FlashcardsRepositoryProtocol.self) { resolver in
            FlashcardsRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
        container.register(DecksRepositoryProtocol.self) { resolver in
            DecksRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
        container.register(WordsRepositoryProtocol.self) { resolver in
            WordsRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
    }
    // swiftlint:enable force_unwrapping
}
