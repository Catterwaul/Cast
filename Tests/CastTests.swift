import Cast
import Testing

struct CastTests {
  @Test func concreteTypes() throws {
    _ = try cast(0) as Int
    #expect(throws: Error.self) { try cast(0) as Bool }
  }

  @Test func metatypes() throws {
    _ = try cast(Void.self) as Void.Type
    typealias IntProtocol = FixedWidthInteger & SignedInteger
    _ = try cast((any IntProtocol).self) as (any IntProtocol).Type
    #expect(throws: Error.self) { try cast(Int.self) as (any IntProtocol).Type }
  }

  @Test func inheritance() throws {
    _ = try cast(0) as any Equatable

    final class Subclass: Class { }
    _ = try cast(Subclass()) as Protocol
    _ = try cast(Subclass()) as Class
    #expect(throws: Error.self) { try cast(Class()) as Subclass }
  }

  @Test func AnyObject() throws {
    _ = try cast(0) as AnyObject
    _ = try cast(Class()) as AnyObject
    _ = try cast(Class() as Protocol) as AnyObject
  }
}

private protocol Protocol { }
private class Class: Protocol { }
