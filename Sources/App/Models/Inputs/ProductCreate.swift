import Vapor
import FluentMongoDriver

struct ProductCreate: Content {
    let name: String
    let description: String
    let price: Int
    let categoryId: ObjectId
}
