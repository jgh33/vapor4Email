//
//  File.swift
//  
//
//  Created by andy.g.h.jiao on 2019/11/13.
//

import Fluent

struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos")
            .field("id", .int, .identifier(auto: true))
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos").delete()
    }
}
