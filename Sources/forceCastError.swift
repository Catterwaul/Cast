/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a value may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A value that might throw an `Error`.
/// - Important: A crash will occur if `value` throws any type but `Error`.
/// - Bug: [`errorType` must be explicitly provided](https://github.com/swiftlang/swift/issues/75674).
public func forceCastError<Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @autoclosure () throws -> Value
) throws(Error) -> Value {
  do { return try value() }
  catch { throw error as! Error }
}

/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Bug: This should use "`each Parameter`" to avoid necessitating an overload
///   for closures that take no parameters, but that doesn't compile.
public func forceCastError<Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping () throws -> Value
) -> () throws(Error) -> Value {
  { try forceCastError(to: Error.self, value()) }
}

/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Bug: This should use "`each Parameter`" to avoid necessitating an overload
///   for closures that take no parameters, but that doesn't compile.
public func forceCastError<Input, Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping (Input) throws -> Value
) -> (Input) throws(Error) -> Value {
  { try forceCastError(to: Error.self, value($0)) }
}

// MARK: - async

/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a value may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A value that might throw an `Error`.
/// - Important: A crash will occur if `value` throws any type but `Error`.
/// - Bug: [`errorType` must be explicitly provided](https://github.com/swiftlang/swift/issues/75674).
public func forceCastError<Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @autoclosure () async throws -> Value
) async throws(Error) -> Value {
  do { return try await value() }
  catch { throw error as! Error }
}

/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Bug: This should use "`each Parameter`" to avoid necessitating an overload
///   for closures that take no parameters, but that doesn't compile.
public func forceCastError<Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping () async throws -> Value
) -> () async throws(Error) -> Value {
  { try await forceCastError(to: Error.self, await value()) }
}

/// A mechanism to interface between untyped and typed errors.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Bug: This should use "`each Parameter`" to avoid necessitating an overload
///   for closures that take no parameters, but that doesn't compile.
public func forceCastError<Input, Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping (Input) async throws -> Value
) -> (Input) async throws(Error) -> Value {
  { try await forceCastError(to: Error.self, await value($0)) }
}
