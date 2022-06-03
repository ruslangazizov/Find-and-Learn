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
        registerDecksFlow(using: container)
        registerAccountFlow(using: container)
        
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
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!,
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!
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
            let router = FavoriteWordsRouter(container: container)
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
            let router = HistoryWordsRouter(container: container)
            let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
            let viewController = HistoryWordsViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(WordDetailViewInput.self) { (resolver, wordModel: WordModel) in
            let interactor = WordDetailInteractor(
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!
            )
            let router = WordDetailRouter(container: container)
            let presenter = WordDetailPresenter(interactor: interactor, router: router, wordModel: wordModel)
            let view = WordDetailViewController(presenter: presenter)
            
            presenter.view = view
            router.view = view
            
            return view
        }
        
        container.register(NewFlashcardViewInput.self) { (resolver, flashcardModel: NewFlashcardModel, deckId: Int?) in
            let interactor = NewFlashcardInteractor(
                decksRepository: resolver.resolve(DecksRepositoryProtocol.self)!,
                flashcardsRepository: resolver.resolve(FlashcardsRepositoryProtocol.self)!
            )
            let router = NewFlashcardRouter()
            let presenter = NewFlashcardPresenter(interactor: interactor, router: router, selectedDeckId: deckId)
            let viewController = NewFlashcardViewController(presenter: presenter, newFlashcardModel: flashcardModel)
            
            router.view = viewController
            presenter.view = viewController
            
            return viewController
        }
    }
    
    private static func registerDecksFlow(using container: Container) {
        container.register(DecksViewInput.self) { resolver in
            let interactor = DecksInteractor(
                decksRepository: resolver.resolve(DecksRepositoryProtocol.self)!,
                stringFormatter: resolver.resolve(StringFormatterProtocol.self)!
            )
            let router = DecksRouter(container: container)
            let presenter = DecksPresenter(interactor: interactor, router: router)
            let viewController = DecksViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(DeckDetailViewInput.self) { (resolver, deck: Deck) in
            let interactor = DeckDetailInteractor(
                flashcardsRepository: resolver.resolve(FlashcardsRepositoryProtocol.self)!
            )
            let router = DeckDetailRouter(container: container)
            let presenter = DeckDetailPresenter(interactor: interactor, router: router, deck: deck)
            let viewController = DeckDetailViewController(
                presenter: presenter,
                flashcards: deck.flashcards,
                deckName: deck.name
            )
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(EditFlashcardViewInput.self) { (resolver, arg1: NewFlashcardModel, arg2: Int, arg3: Int) in
            let interactor = EditFlashcardInteractor(
                decksRepository: resolver.resolve(DecksRepositoryProtocol.self)!,
                flashcardsRepository: resolver.resolve(FlashcardsRepositoryProtocol.self)!
            )
            let router = EditFlashcardRouter()
            let presenter = EditFlashcardPresenter(
                interactor: interactor,
                router: router,
                flashcardId: arg2,
                selectedDeckId: arg3
            )
            let view = NewFlashcardViewController(presenter: presenter, newFlashcardModel: arg1)
            
            router.view = view
            presenter.view = view
            
            return view
        }
        
        container.register(StudyingViewInput.self) { (resolver, models: [Flashcard]) in
            let interactor = StudyingInteractor(
                studyingManager: resolver.resolve(StudyingManagerProtocol.self)!,
                flashcardsRepository: resolver.resolve(FlashcardsRepositoryProtocol.self)!
            )
            let router = StudyingRouter()
            let presenter = StudyingPresenter(router: router, interactor: interactor)
            let viewController = StudyingViewController(presenter: presenter, cards: models)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
    }
    
    private static func registerAccountFlow(using container: Container) {
        container.register(ConfirmEmailViewInput.self) { resolver in
            let router = ConfirmEmailRouter()
            let interactor = ConfirmEmailInteractor(
                userManager: resolver.resolve(UserManagerProtocol.self)!
            )
            let presenter = ConfirmEmailPresenter(interactor: interactor, router: router)
            let viewController = ConfirmEmailViewController(presenter: presenter)
            
            router.view = viewController
            presenter.view = viewController
            
            return viewController
        }
        
        container.register(AchievementsViewInput.self) { resolver in
            let interactor = AchievementsInteractor(
                achievementManager: resolver.resolve(AchievementsManagerProtocol.self)!
            )
            let presenter = AchievementsPresenter(interactor: interactor)
            let viewController = AchievementsViewController(presenter: presenter)
            
            presenter.view = viewController
            
            return viewController
        }
        
        container.register(ChangePasswordViewInput.self) { resolver in
            let interactor = ChangePasswordInteractor(
                validationManager: resolver.resolve(ValidationManagerProtocol.self)!,
                networkManager: resolver.resolve(NetworkManagerProtocol.self)!,
                userManager: resolver.resolve(UserManagerProtocol.self)!,
                tokensManager: resolver.resolve(TokensManagerProtocol.self)!
            )
            let router = ChangePasswordRouter()
            let presenter = ChangePasswordPresenter(interactor: interactor, router: router)
            let viewController = ChangePasswordViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
            return viewController
        }
        
        container.register(AccountViewInput.self) { resolver in
            let interactor = AccountInteractor(
                tokensManager: resolver.resolve(TokensManagerProtocol.self)!,
                settingsManager: resolver.resolve(SettingsManagerProtocol.self)!,
                userManager: resolver.resolve(UserManagerProtocol.self)!,
                networkManager: resolver.resolve(NetworkManagerProtocol.self)!,
                wordsRepository: resolver.resolve(WordsRepositoryProtocol.self)!,
                decksRepository: resolver.resolve(DecksRepositoryProtocol.self)!
            )
            let router = AccountRouter(container: container)
            let presenter = AccountPresenter(interactor: interactor, router: router)
            let viewController = AccountViewController(presenter: presenter)
            
            presenter.view = viewController
            router.view = viewController
            
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
