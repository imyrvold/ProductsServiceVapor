import Fluent
import Vapor
import FluentMongoDriver

struct CategoriesController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.group("categories") { categories in
            let authenticated = categories.grouped(Payload.authenticator(), Payload.guardMiddleware())
            authenticated.get(use: get)
            authenticated.post(use: new)
            authenticated.patch(use: edit)
            authenticated.delete(use: delete)
        }
    }
    
    func get(_ request: Request)throws -> EventLoopFuture<[CategoryResponse]> {
        return Category.query(on: request.db).all().map { cats in
            return cats.map { CategoryResponse(id: $0.id!, name: $0.name) }
        }
    }
    
    func new(_ request: Request)throws -> EventLoopFuture<CategoryResponse> {
        let input = try request.content.decode(CategoryInput.self)
        let category = Category(name: input.name)
        return category.save(on: request.db).map { _ in
            return CategoryResponse(id: category.id!, name: category.name)
        }
    }
    
    func edit(_ request: Request)throws -> EventLoopFuture<CategoryResponse> {
        if let id = ObjectId(request.parameters.get("id") ?? "") {
            let input = try request.content.decode(CategoryInput.self)
            
            return Category.query(on: request.db).filter(\.$id == id).all().flatMap { categories in
                if categories.count == 0 {
                    return request.eventLoop.makeFailedFuture(Abort(.badRequest, reason: "No product. found!"))
                }
                let category = categories.first!
                
                category.name = input.name
                
                return category.save(on: request.db).map { _ in
                    return CategoryResponse(id: category.id!, name: category.name)
                }
            }
        }
        else {
            throw Abort(.badRequest, reason: "No input given.")
        }
    }
    
    func delete(_ request: Request)throws -> EventLoopFuture<HTTPStatus> {
        if let id = ObjectId(request.parameters.get("id") ?? "") {
            return Category.query(on: request.db).filter(\.$id == id).delete().map { _ in
                return .ok
            }
        }
        else {
            throw Abort(.badRequest, reason: "No id given.")
        }
    }
}
