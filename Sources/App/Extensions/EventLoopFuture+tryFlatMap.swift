import Vapor


extension EventLoopFuture {
    func tryFlatMap<NewValue>(file: StaticString = #file, line: UInt = #line, _ callback: @escaping (Value) throws -> EventLoopFuture<NewValue>) -> EventLoopFuture<NewValue> {
        flatMap(file: file, line: line) { result in
            do {
                return try callback(result)
            } catch {
                return self.eventLoop.makeFailedFuture(error, file: file, line: line)
            }
        }
    }
}
