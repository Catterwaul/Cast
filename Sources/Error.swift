/// An error that represents an impossible casting attempt. 🧙‍♀️🙀
/// - Bug: This should also have "`Uncast`" and "`Cast`" generic placeholders,
/// but it's not possible to work with them yet, due to
/// [this bug](https://github.com/swiftlang/swift/issues/74383)
/// and [this other bug](https://github.com/swiftlang/swift/issues/74289).
public struct Error: Swift.Error {
  public init() { }
}

/// Like a throwing version of `as?`.
/// - Note: The return type can be inferred, which the various forms of `as` do not support.
public func cast<Uncast, Cast>(_ uncast: Uncast) throws(Error) -> Cast {
  guard case let cast as Cast = uncast else { throw .init() }
  return cast
}
