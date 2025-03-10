import Cast
import Testing

struct ForceCastErrorTests {
  @Test func autoclosure() {
    #expect(throws: Error.self) {
      try forceCastError(to: Error.self, `throw`())
    }
  }

  @Test func autoclosure_async() async {
    await #expect(throws: Error.self) {
      try await forceCastError(to: Error.self, await `throw`())
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

  @Test func nonzeroParameterClosure() {
    #expect(throws: Error.self) {
      try (forceCastError { _ in throw Error() } as (_) throws(Error) -> _)("🐱")
    }
  }

  @Test func nonzeroParameterClosure_async() async {
    await #expect(throws: Error.self) {
      try await (forceCastError { _ async throws in throw Error() } as (_) async throws(Error) -> _)("🐱")
    }
  }
}

private struct Error: Swift.Error { }
private func `throw`() throws { throw Error() }
private func `throw`() async throws { throw Error() }
