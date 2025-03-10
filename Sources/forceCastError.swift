// MARK: - synchronous

/// Retrieve a value or convert an untyped error to a known type.
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

/// Convert a closure that throws `any Error` to a typed throwing closure.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Important: A crash will occur if `value` throws any type but `Error`.
/// - Returns: A closure. It will have typed error information, which is good,
/// but of course will lose argument labels if `value` is a function.
public func forceCastError<each Input, Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping (repeat each Input) throws -> Value
) -> (repeat each Input) throws(Error) -> Value {
  { (input: repeat each Input) in
    try forceCastError(to: Error.self, value(repeat each input))
  }
}

// MARK: - asynchronous

/// Retrieve a value or convert an untyped error to a known type.
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

/// Convert a closure that throws `any Error` to a typed throwing closure.
///
/// When you know for certain that a closure may only throw one type of error,
/// but that guarantee is not (or, due to compiler bugs, cannot be) represented in the type system,
/// you can use this to "convert" it to "typed throws".
/// - Parameters:
///   - errorType: The error type known for certain to be thrown by `value`.
///   - value: A closure that might throw an `Error`.
/// - Important: A crash will occur if `value` throws any type but `Error`.
/// - Returns: A closure. It will have typed error information, which is good,
/// but of course will lose argument labels if `value` is a function.
public func forceCastError<each Input, Value, Error>(
  to errorType: Error.Type = Error.self,
  _ value: @escaping (repeat each Input) async throws -> Value
) -> (repeat each Input) async throws(Error) -> Value {
  { (input: repeat each Input) in
    try await forceCastError(to: Error.self, await value(repeat each input))
  }
}
