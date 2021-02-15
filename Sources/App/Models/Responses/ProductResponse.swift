import Vapor
import FluentMongoDriver

struct ProductResponse: Content {
    let id: ObjectId
    let name: String
    let description: String
    let price: Int
}
