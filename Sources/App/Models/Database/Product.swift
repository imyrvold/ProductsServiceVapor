import Vapor
import Fluent
import FluentMongoDriver

final class Product: Model {
    
    static let schema = "products"
    
    @ID(custom: .id) var id: ObjectId?

    @Field(key: .name)
    var name: String
    
    @Field(key: .description)
    var description: String
    
    @Field(key: .price)
    var price: Int
    
    @Field(key: .categoryId)
    var categoryId: ObjectId
    
    @Timestamp(key: .createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: .updatedAt, on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: .deletedAt, on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: ObjectId? = nil, name: String, description: String, price: Int, categoryId: ObjectId) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.categoryId = categoryId
    }
}

extension FieldKey {
    static var description: Self { "description" }
    static var price: Self { "price" }
    static var categoryId: Self { "categoryId" }
    static var createdAt: Self { "createdAt" }
    static var updatedAt: Self { "updatedAt" }
    static var deletedAt: Self { "deletedAt" }
}
