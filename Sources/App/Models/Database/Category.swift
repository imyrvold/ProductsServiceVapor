import Vapor
import Fluent
import FluentMongoDriver

final class Category: Model {
    
    static let schema = "categories"
    
    @ID(custom: .id) var id: ObjectId?

    @Field(key: .name)
    var name: String
    
    init() {}
    
    init(name: String) {
        self.name = name
    }
}

extension FieldKey {
    static var name: Self { "name" }
}
