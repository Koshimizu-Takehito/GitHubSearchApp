import Foundation
import Kingfisher
import APIKit
import Swinject

// MARK: - Assembler
extension Assembler {
    static let assembler = Assembler([
        UtilsAssembly(),
        ServiceAssembly(),
        UseCaseAssembly(),
        PresenterAssembly()
    ])
}

// MARK: - Utils Assembly
private final class UtilsAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(RequestSendable.self) { _ in
                Session.shared
            }
    }
}

// MARK: - Service Assembly
private final class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(GitHubItemsRepositiry.self) { _ in
                GitHubItemsOnMemoryRepositiry.shared
            }
        container
            .register(GitHubItemRepositiry.self) { _ in
                GitHubItemsOnMemoryRepositiry.shared
            }
        container
            .register(ImageLoadable.self) { _ in
                KingfisherManager.shared
            }
        container
            .register(ImageCachable.self) { _ in
                ImageCache.default
            }
        container
            .register(ImageManaging.self) { resolver in
                ImageManager(loadable: resolver.resolve(), cachable: resolver.resolve())
            }
    }
}

// MARK: - UseCase Assembly
private final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(GitHubSearchUseCase.self) { resolver in
                GitHubSearchInteractor(session: resolver.resolve(), repositiry: resolver.resolve())
            }
        container
            .register(GitHubDetailUseCase.self) { resolver in
                GitHubDetailInteractor(repositiry: resolver.resolve())
            }
    }
}

// MARK: - Presenter Assembly
private final class PresenterAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private extension Resolver {
    func resolve<Service>() -> Service {
        self.resolve(Service.self)!
    }
}
