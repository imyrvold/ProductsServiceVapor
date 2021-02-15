import Fluent
import Vapor
import JWT

func routes(_ app: Application) throws {
    
    app.group("api") { api in
        api.get("health") { _ in
            return "All good!"
        }
        
        // Authentication
        try! api.register(collection: ProductsController())
        try! api.register(collection: CategoriesController())
    }
}
