import Swinject

private var resolver: any Resolver {
    return Assembler.assembler.resolver
}

// MARK: - Injected
@propertyWrapper
struct Injected<T> {
    let wrappedValue: T

    init() {
        wrappedValue = resolver.resolve(T.self)!
    }

    init(name: String) {
        wrappedValue = resolver.resolve(T.self, name: name)!
    }

    init<Arg1>(argument: Arg1) {
        wrappedValue = resolver.resolve(T.self, argument: argument)!
    }

    init<Arg1>(name: String, argument: Arg1) {
        wrappedValue = resolver.resolve(T.self, name: name, argument: argument)!
    }

    init<Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) {
        wrappedValue = resolver.resolve(T.self, arguments: arg1, arg2)!
    }

    init<Arg1, Arg2>(name: String, arguments arg1: Arg1, _ arg2: Arg2) {
        wrappedValue = resolver.resolve(T.self, name: name, arguments: arg1, arg2)!
    }

    init<Arg1, Arg2, Arg3>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) {
        wrappedValue = resolver.resolve(T.self, arguments: arg1, arg2, arg3)!
    }

    init<Arg1, Arg2, Arg3>(name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) {
        wrappedValue = resolver.resolve(T.self, name: name, arguments: arg1, arg2, arg3)!
    }

    init<Arg1, Arg2, Arg3, Arg4>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) {
        wrappedValue = resolver.resolve(T.self, arguments: arg1, arg2, arg3, arg4)!
    }

    init<Arg1, Arg2, Arg3, Arg4>(name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) {
        wrappedValue = resolver.resolve(T.self, name: name, arguments: arg1, arg2, arg3, arg4)!
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) {
        wrappedValue = resolver.resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5)!
    }

    init<Arg1, Arg2, Arg3, Arg4, Arg5>(name: String?, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) {
        wrappedValue = resolver.resolve(T.self, name: name, arguments: arg1, arg2, arg3, arg4, arg5)!
    }
}
