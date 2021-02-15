import Vapor
import FluentMongoDriver

struct CategoryResponse: Content {
    let id: ObjectId
    let name: String
}
