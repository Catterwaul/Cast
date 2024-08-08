import Cast
import Testing

struct ForceCastErrorTests {
  @Test func sync() {
    func `throw`() throws { throw Error() }

    #expect(throws: Error.self) {
      try forceCastError(to: Error.self, `throw`())
    }

    #expect(throws: Error.self) {
      try (forceCastError(`throw`) as () throws(Error) -> _)()
    }

    #expect(throws: Error.self) {
      try (forceCastError { _ in throw Error() } as (Int) throws(Error) -> _)(0)
    }
  }

  @Test func async() async {
    func `throw`() async throws { throw Error() }

    await #expect(throws: Error.self) {
      try await forceCastError(to: Error.self, await `throw`())
    }

    await #expect(throws: Error.self) {
      try await (forceCastError(`throw`) as () async throws(Error) -> _)()
    }

    await #expect(throws: Error.self) {
      try await (forceCastError { _ async throws in throw Error() } as (Int) async throws(Error) -> _)(0)
    }
  }
}

private struct Error: Swift.Error { }
