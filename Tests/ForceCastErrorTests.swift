import Cast
import Testing

struct ForceCastErrorTests {
  @Test func autoclosure() {
    #expect(throws: Error.self) {
      try `throw`() ¿! Error.self
    }
  }

  @Test func autoclosure_async() async {
    await #expect(throws: Error.self) {
      try await (await `throw`()) ¿! Error.self
    }
  }

  @Test func zeroParameterClosure() {
    #expect(throws: Error.self) {
      try (forceCastError(`throw`) as () throws(Error) -> _)()
    }
  }

  @Test func zeroParameterClosure_async() async {
    await #expect(throws: Error.self) {
      try await (forceCastError(`throw`) as () async throws(Error) -> _)()
    }
  }

  @Test func nonzeroParameterClosure() throws {
    var throwAny = { (_: String) throws -> String in throw Error() }
    var throwError: (_) throws(Error) -> _ = forceCastError(throwAny)
    #expect(throws: Error.self) { try throwError("🐱") }
    throwAny = { $0 }
    throwError = forceCastError(throwAny)
    #expect(try throwError("🐱") == "🐱")
  }

  @Test func nonzeroParameterClosure_async() async throws {
    var throwAny = { (_: String) async throws -> String in throw Error() }
    var throwError: (_) async throws(Error) -> _ = forceCastError(throwAny)
    await #expect(throws: Error.self) { try await throwError("🐱") }
    throwAny = { $0 }
    throwError = forceCastError(throwAny)
    #expect(try await throwError("🐱") == "🐱")
  }
}

private struct Error: Swift.Error { }
private func `throw`() throws { throw Error() }
private func `throw`() async throws { throw Error() }
