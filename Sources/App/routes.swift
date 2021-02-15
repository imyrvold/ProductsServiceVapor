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
//    let root = app.grouped(.anything, "products")
//    let auth = root.grouped(UserAuthenticator())
//
//    root.get("health") { req in
//        return "All good!"
//    }
//
//    let productsController = ProductsController()
//    let categoriesController = CategoriesController()
//
//    root.get("categories", use: categoriesController.get)
//    auth.post("categories", use: categoriesController.new)
//    auth.patch("categories/:id", use: categoriesController.edit)
//    auth.delete("categories/:id", use: categoriesController.delete)
//
//    root.get(use: productsController.get)
//    auth.post(use: productsController.new)
//    auth.patch(":id", use: productsController.edit)
//    auth.delete(":id", use: productsController.delete)
}
