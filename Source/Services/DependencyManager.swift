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
        
        return container
    }
    
    static func registerServices(using container: Container) {
        container.register(UserManagerProtocol.self) { _ in UserManager() }.inObjectScope(.container)
        container.register(NetworkManagerProtocol.self) { _ in NetworkManager() }
        container.register(StringFormatterProtocol.self) { _ in StringFormatter() }.inObjectScope(.container)
        container.register(AchievementsManagerProtocol.self) { _ in AchievementsManager() }.inObjectScope(.container)
        container.register(StudyingManagerProtocol.self) { _ in StudyingManager() }
        container.register(SettingsManagerProtocol.self) { _ in SettingsManager() }.inObjectScope(.container)
        container.register(ValidationManagerProtocol.self) { _ in ValidationManager() }.inObjectScope(.container)
        container.register(TokensManagerProtocol.self) { _ in TokensManager() }.inObjectScope(.container)
        
        container.register(CoreDataManagerProtocol.self) { _ in CoreDataManager.shared }.inObjectScope(.container)
        // swiftlint:disable force_unwrapping
        container.register(FlashcardsRepositoryProtocol.self) { resolver in
            FlashcardsRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
        container.register(DecksRepositoryProtocol.self) { resolver in
            DecksRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
        container.register(WordsRepositoryProtocol.self) { resolver in
            WordsRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self)!)
        }
        // swiftlint:enable force_unwrapping
    }
}
