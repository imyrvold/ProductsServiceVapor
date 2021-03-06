import Vapor
import FluentMongoDriver

struct ProductInput: Content {
    let name: String
    let description: String
    let price: Int
    let categoryId: ObjectId
}
