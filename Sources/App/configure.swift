import Vapor
import FluentMySQLDriver
import Fluent

/// Called before your application initializes.
func configure(_ app: Application) throws {
    // Register providers first
    app.provider(FluentProvider())

    // Register middleware
    app.register(extension: MiddlewareConfiguration.self) { middlewares, app in
        // Serves files from `Public/` directory
        // middlewares.use(app.make(FileMiddleware.self))
    }
    
//    app.databases.sqlite(
//        configuration: .init(storage: .connection(.file(path: "db.mysql"))),
//        threadPool: app.make(),
//        poolConfiguration: app.make(),
//        logger: app.make(),
//        on: app.make()
//    )
    let mysqlConf = MySQLConfiguration(hostname: "localhost", port: 3306, username: "root", password: "00000000", database: "tiyuke", tlsConfiguration: TLSConfiguration.forClient(certificateVerification: .none))
    app.databases.mysql(configuration: mysqlConf, on: app.make())
    
    app.register(Migrations.self) { c in
        var migrations = Migrations()
        migrations.add(CreateTodo(), to: .mysql)
        return migrations
    }
    
    try routes(app)
}
