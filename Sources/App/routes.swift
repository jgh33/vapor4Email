import Fluent
import Vapor
import SwiftSMTP

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }
    
    struct EmailInfo:Content {
        var email: String
        var code: String
    }
    app.post("smtp") { req -> String in
//        let smtp = SMTP(
//            hostname: "smtpdm.aliyun.com:80",     // SMTP server address
//            email: "steerdream@steerdream.com",        // username to login
//            password: "GXfc123456"            // password to login
//        )
        let info = try req.content.decode(EmailInfo.self)
        let smtp = SMTP(hostname: "smtpdm.aliyun.com", email: "steerdream@steerdream.com", password: "GXfc123456", port: 80, tlsMode: .ignoreTLS, tlsConfiguration: nil, authMethods: [], domainName: "steerdream.com", timeout: 1000)
        let drLight = Mail.User(name: "Steer", email: "steerdream@steerdream.com")
        let megaman = Mail.User(name: "Mr.Jiao", email: info.email)  //"jiaoguohui33@gmail.com"

        let mail = Mail(
            from: drLight,
            to: [megaman],
            subject: "Humans and robots living together in harmony and equality.",
            text: "<p>the code is \(info.code).</p>"
        )

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
}
