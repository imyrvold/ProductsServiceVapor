import Fluent
import FluentMongoDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // MARK: JWT
    guard let jwksString = Environment.get("JWKS_KEYPAIR") else { fatalError("No value was found at the given public key environment 'JWKS_KEYPAIR'") }
    try app.jwt.signers.use(jwksJSON: jwksString)
    app.middleware.use(CORSMiddleware())
    app.middleware.use(ErrorMiddleware() { request, error in
        struct ErrorResponse: Content {
            var error: String
        }
        let data: Data?
        do {
            data = try JSONEncoder().encode(ErrorResponse(error: "\(error)"))
        }
        catch {
            data = "{\"error\":\"\(error)\"}".data(using: .utf8)
        }
        let res = Response(status: .internalServerError, body: Response.Body(data: data!))
        res.headers.replaceOrAdd(name: .contentType, value: "application/json")
        return res
    })

    // MARK: Database
    
    guard let connectionString = Environment.get("MONGODB") else {
        fatalError("No MongoDB connection string is available in .env")
    }

    app.databases.use(try .mongo(connectionString: connectionString), as: .mongo)
    
    try routes(app)
}
